import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

enum SettingsEncodeType {
  encode,
  decode,
}

enum SettingsPersistStatus {
  success,
  fail,
  skipped,
}

abstract class AppSettingsProvider<T> {
  static Map<String, Function> _registeredDecoders = <String, Function>{};
  static Map<String, Function> _registeredEncoders = <String, Function>{};

  /// Registers an encoder and decoder for a specific type name. By default, only 'native' types
  /// (String, bool, num, etc) and Maps/Lists of native types will be serialized. Any functions
  /// registered here will be available for all AppSettingsProviders (if they use them).
  static void registerTypeCoding(String kind, {@required Function decoder, @required Function encoder}) {
    if (_registeredDecoders == null) {
      _registeredDecoders = <String, Function>{};
    }
    if (_registeredEncoders == null) {
      _registeredEncoders = <String, Function>{};
    }
    if (decoder != null) {
      _registeredDecoders[kind.toLowerCase()] = decoder;
    }
    if (encoder != null) {
      _registeredEncoders[kind.toLowerCase()] = encoder;
    }
  }

  /// Returns true if the settings values contains a value for key.
  bool hasValue(String key) {
    return false;
  }

  /// Returns the value for [key].
  T value(String key) => null;

  /// Stores a value for a provided key. May only store the value temporarily. How the value
  /// is stored is provider dependent. May require calling [persist] to store the value
  /// permanently.
  void setValue(String key, T value) {}

  /// Persist the values (if supported by the provider). Note: calling persist could have
  /// serious implications on the performance of your app so be careful calling it too
  /// often. Check the documentation of each specific provider for details.
  Future<SettingsPersistStatus> persist() async => SettingsPersistStatus.skipped;

  /// Clear all of the stored values.
  Future<SettingsPersistStatus> clear() async => SettingsPersistStatus.skipped;
}

/// This settings provider class will store application settings in memory only. The values here
/// will not be persisted to disk / permanent storage so will be lost if the instance is
/// deallocated or the app restarts.
class InMemoryAppSettings extends AppSettingsProvider<Object> {
  // In-memory storage of application default values.
  Map<String, Object> _valuesCache = <String, Object>{};
  bool hasValue(String key) => _valuesCache.containsKey(key);
  Object value(String key) => _valuesCache[key];
  void setValue(String key, Object value) {
    if (_valuesCache == null) {
      _valuesCache = <String, Object>{};
    }
    _valuesCache[key] = value;
  }

  bool boolValue(String key, {bool defaultValue = false}) {
    Object val = _valuesCache[key];
    if (val == null || !(val is bool)) {
      return defaultValue;
    }
    return val;
  }

  String stringValue(String key, {String defaultValue = null}) {
    Object val = _valuesCache[key];
    if (val == null || !(val is String)) {
      return defaultValue;
    }
    return val;
  }

  int intValue(String key, {int defaultValue = 0}) {
    Object val = _valuesCache[key];
    if (val == null || !(val is int)) {
      return defaultValue;
    }
    return val;
  }

  @override
  Future<SettingsPersistStatus> persist() async => SettingsPersistStatus.success;

  @override
  Future<SettingsPersistStatus> clear() async {
    _valuesCache = <String, Object>{};
    return SettingsPersistStatus.success;
  }
}

class PersistedAppSettings extends InMemoryAppSettings {
  final String kAppSettingsFilename = "__app_settings";

  bool _isUpToDate = false;

  /// Are all the values in sync with the persistent storage?
  bool get isUpToDate => _isUpToDate;

  PersistedAppSettings({Function onReady}) {
    _valuesCache = <String, Object>{};
    _isUpToDate = false;
  }

  Future<PersistedAppSettings> load() async {
    Map<String, Object> settings = await _retrievePersistedValues();
    _valuesCache = settings ?? <String, Object>{};
    _isUpToDate = true;
    return this;
  }

  Future<Map<String, Object>> _retrievePersistedValues() async {
    Map<String, Object> outMap = <String, Object>{};
    File settingsFile = await _getLocalFile().catchError((err) {
      print("Error accessing settings file: $err");
      throw err;
    });
    bool fileExists = await settingsFile.exists();
    if (fileExists) {
      String jsonString = await settingsFile.readAsString();
      if (jsonString.length > 0) {
        Map<String, Object> jsonObj = JSON.decode(jsonString);
        if (jsonObj != null) {
          outMap = _processInputMap(source: jsonObj, encodeType: SettingsEncodeType.decode);
        }
      }
    }
    return outMap;
  }

  // get a reference to the file that will store the serialized application
  // values
  Future<File> _getLocalFile() async {
    String dir = (await PathProvider.getApplicationDocumentsDirectory()).path;
    return new File('$dir/$kAppSettingsFilename');
  }

  Object _serializedValue(Object value) {
    String kind = value.runtimeType.toString();
    Object outValue;
    if (value is String || value is bool || value is num) {
      outValue = value;
    } else if (value is Map) {
      outValue = _processInputMap(source: value, encodeType: SettingsEncodeType.encode);
    } else if (!(value is List || value is Set)) {
      String kind = value.runtimeType.toString().toLowerCase();
      Function encoder = AppSettingsProvider._registeredEncoders[kind];
      if (encoder != null) {
        String encodedValue = Function.apply(encoder, [value]);
        if (encodedValue != null) {
          outValue = encodedValue;
        }
      }
    } else {
      print("Skipping value because '${value.runtimeType}' isn't able to be serialized.");
    }
    return <String, Object>{
      "kind": kind,
      "value": outValue,
    };
  }

  Object _deserializedValue(Map<String, Object> prefObj) {
    String kind = prefObj["kind"].toString().toLowerCase();
    Object prefValue = prefObj["value"];
    Object outValue;
    if (kind == "string" || kind == "bool" || kind == "num") {
      outValue = prefValue;
    } else if (kind == "map") {
      outValue = _processInputMap(source: prefValue, encodeType: SettingsEncodeType.decode);
    } else if (kind != "list" && kind != "set") {
      Function decodeFunction = AppSettingsProvider._registeredDecoders[kind];
      if (decodeFunction != null) {
        Object decodedValue = Function.apply(decodeFunction, [prefValue]);
        if (decodedValue != null) {
          outValue = decodedValue;
        }
      }
    }
    return outValue;
  }

  Map<String, Object> _processInputMap({
    @required Map<String, Object> source,
    @required SettingsEncodeType encodeType,
  }) {
    Map<String, Object> outMap = <String, Object>{};
    source.forEach((String key, Object value) {
      if (value is List) {
        List<Object> valueList = <Object>[];
        value.forEach((listValue) {
          Object convertedValue =
          encodeType == SettingsEncodeType.encode ? _serializedValue(listValue) : _deserializedValue(listValue);
          if (convertedValue != null) {
            valueList.add(convertedValue);
          }
        });
        outMap[key] = valueList;
      } else {
        Object convertedValue =
        encodeType == SettingsEncodeType.encode ? _serializedValue(value) : _deserializedValue(value);
        if (convertedValue != null) {
          outMap[key] = convertedValue;
        }
      }
    });
    return outMap;
  }

  @override
  Future<SettingsPersistStatus> persist({bool force = false}) async {
    if (_isUpToDate && force == false) {
      return SettingsPersistStatus.skipped;
    }
    await super.persist();
    Map<String, Object> jsonObject = _processInputMap(source: _valuesCache, encodeType: SettingsEncodeType.encode);
    String json = JSON.encode(jsonObject);
    File settingsFile = await _getLocalFile();
    await settingsFile.writeAsString(json).catchError((err) {
      print("Settings write failed: $err");
      return SettingsPersistStatus.fail;
    });
    return SettingsPersistStatus.success;
  }

  @override
  Future<SettingsPersistStatus> clear() {
    return super.clear().then((SettingsPersistStatus wasCleared) async {
      await _getLocalFile().then((file) {
        file.delete().then((entity) {
          return SettingsPersistStatus.success;
        }, onError: (e) {
          print("Setting clear failed: $e");
          return SettingsPersistStatus.fail;
        });
      });
    });
  }

  @override
  void setValue(String key, Object value) {
    super.setValue(key, value);
    _isUpToDate = false;
  }
}
