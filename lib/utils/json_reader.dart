import 'dart:convert';
import 'package:intl/intl.dart';

typedef ListItemMapper<T, R> = R Function(T item);

class InvalidJsonValueException implements Exception {
  final dynamic value;

  InvalidJsonValueException(this.value);

  @override
  String toString() {
    return 'InvalidJsonValueException{value: $value}';
  }
}

/// Provides safe access to JSON values.
/// Any null field values are automatically replaced with default ones.
///
/// Examples:
/// Get top field value:
/// ```
/// final json = '''
/// {
///   'topField': 'Hello',
///   'object1': {
///      'object2': {
///         'int': 0
///      }
///   }
/// }
/// ''';
/// final value = JsonReader(json)['topField'].asString();
/// ```
///
/// Get nested field value:
/// ```
/// final json = '''
/// {
///   'object1': {
///      'object2': {
///         'int': 0
///      }
///   }
/// }
/// ''';
/// final value = JsonReader(json)['object1']['object2']['int'].asInt()
/// ```
///
/// Get nested list of ints:
/// ```
/// final json = '''
/// {
///   'object1': {
///      'object2': {
///         'int': 0,
///         'list': [0, 1, 2, 3]
///      }
///   }
/// }
/// ''';
/// final value = JsonReader(json)['object1']['object2']['list'].asListOf<int>();
/// ```
class JsonReader {
  final dynamic json;

  final bool _permissive;
  final int _defaultInt;
  final double _defaultDouble;
  final bool _defaultBool;
  final String _defaultString;
  final bool _trimStrings;
  late DateTime _defaultDateTime;

  factory JsonReader(
    dynamic json, {
    bool permissive = true,
  }) =>
      JsonReader._(json, permissive: permissive);

  JsonReader._(
    this.json, {
    bool permissive = true,
    int defaultInt = 0,
    double defaultDouble = 0,
    bool defaultBool = false,
    String defaultString = '',
    bool trimStrings = true,
    DateTime? defaultDateTime,
  })  : _permissive = permissive,
        _defaultInt = defaultInt,
        _defaultDouble = defaultDouble,
        _defaultBool = defaultBool,
        _defaultString = defaultString,
        _trimStrings = trimStrings {
    _defaultDateTime = defaultDateTime ?? DateTime.utc(0);

    final isValidJson = json == null ||
        json is Map ||
        json is List ||
        json is String ||
        json is bool ||
        json is num;

    if (!isValidJson) {
      throw InvalidJsonValueException(json);
    }
  }

  int asInt({
    bool? permissive,
    int? defaultValue,
  }) =>
      _getInt(
        json,
        permissive: permissive ?? _permissive,
        defaultValue: defaultValue ?? _defaultInt,
      );

  double asDouble({
    bool? permissive,
    double? defaultValue,
  }) =>
      _getDouble(
        json,
        permissive: permissive ?? _permissive,
        defaultValue: defaultValue ?? _defaultDouble,
      );

  String asString({
    bool? permissive,
    bool? trim,
    String? defaultValue,
  }) =>
      _getStr(
        json,
        permissive: permissive ?? _permissive,
        trim: trim ?? _trimStrings,
        defaultValue: defaultValue ?? _defaultString,
      );

  bool asBool({
    bool? permissive,
    bool? defaultValue,
  }) =>
      _getBool(
        json,
        permissive: permissive ?? _permissive,
        defaultValue: defaultValue ?? _defaultBool,
      );

  DateTime asDateTime({
    bool? permissive,
    DateTime? defaultValue,
  }) =>
      _getDateTime(
        json,
        permissive: permissive ?? _permissive,
        defaultValue: defaultValue ?? _defaultDateTime,
      );

  Map<String, dynamic> asObject() => asMap();

  Map<String, dynamic> asMap() {
    final dynamic v = json;
    if (v == null && _permissive) {
      return const <String, dynamic>{};
    }
    if (v is! Map<String, dynamic>) {
      throw ArgumentError.value(json, 'json', 'must be a map');
    }

    // ignore: unnecessary_cast
    return v as Map<String, dynamic>;
  }

  List<T> asListOf<T>() {
    final dynamic v = json;
    if (v == null && _permissive) {
      return const [];
    }
    if (v is List && v.every((dynamic item) => item is T)) {
      return v.cast<T>();
    }
    throw ArgumentError.value(json, 'json', 'must be a list of $T');
  }

  List<Map<String, dynamic>> asListOfObjects() =>
      asListOf<Map<String, dynamic>>();

  bool containsKey(Object key) {
    final dynamic v = json;
    if (v == null) {
      return false;
    }
    if (v is Map) {
      return v.containsKey(key);
    }
    return false;
  }

  JsonReader operator [](Object key) {
    assert(key is int || key is String);

    if (key is int && json is List) {
      final list = _getList(json);
      final listItemReader = list[key];
      return listItemReader;
    } else if (key is String && json is Map) {
      final map = _getMap(json);
      final mapItemReader = map[key];
      return mapItemReader ?? JsonReader(null);
    }
    return JsonReader(null);
  }

  @override
  String toString() {
    try {
      return jsonEncode(json);
    } catch (_) {
      return '';
    }
  }
}

int _getInt(
  dynamic value, {
  bool permissive = true,
  int defaultValue = 0,
}) {
  final dynamic v = value;
  if (v is int) {
    return v;
  } else if (permissive && v is num) {
    return v.toInt();
  } else if (permissive && v is String) {
    return int.tryParse(v) ?? defaultValue;
  } else if (permissive && v == null) {
    return defaultValue;
  } else {
    throw ArgumentError('Illegal type: ${v.runtimeType}');
  }
}

double _getDouble(
  dynamic value, {
  bool permissive = true,
  double defaultValue = 0,
}) {
  final dynamic v = value;

  if (v is double) {
    return v;
  } else if (permissive && v is num) {
    return v.toDouble();
  } else if (permissive && v == null) {
    return defaultValue;
  } else {
    throw ArgumentError('Illegal type: ${v.runtimeType}');
  }
}

String _getStr(
  dynamic value, {
  bool permissive = true,
  bool trim = true,
  String defaultValue = '',
}) {
  final dynamic v = value ?? defaultValue;
  if (v is String) {
    if (trim) {
      return v.trim();
    } else {
      return v;
    }
  } else if (permissive) {
    return v.toString();
  } else {
    throw ArgumentError('Illegal type: ${v.runtimeType}');
  }
}

bool _getBool(
  dynamic value, {
  bool permissive = true,
  bool defaultValue = false,
}) {
  final dynamic v = value ?? defaultValue;
  if (v is bool) {
    return v;
  } else if (permissive && v is int) {
    return v > 0;
  } else {
    throw ArgumentError('Illegal type: ${v.runtimeType}');
  }
}

Map<String, JsonReader> _getMap(
  dynamic value, {
  Map<String, dynamic> defaultValue = const <String, JsonReader>{},
}) {
  final dynamic v = value ?? defaultValue;
  if (v is Map && v.keys.every((dynamic k) => k is String)) {
    return v
        .map((dynamic k, dynamic v) => MapEntry(k as String, JsonReader._(v)));
  } else {
    throw ArgumentError('Illegal type: ${v.runtimeType}');
  }
}

List<JsonReader> _getList(
  dynamic value, {
  List defaultValue = const <dynamic>[],
}) {
  final dynamic v = value ?? defaultValue;
  if (v is Iterable) {
    return v.map((dynamic item) => JsonReader._(item)).toList();
  } else {
    throw ArgumentError('Illegal type: ${v.runtimeType}');
  }
}

DateTime _getDateTime(
  dynamic value, {
  bool permissive = true,
  DateTime? defaultValue,
}) {
  defaultValue ??= DateTime.utc(0);

  final dynamic v = value ?? defaultValue;
  if (v is DateTime) {
    return v;
  } else if (v is String) {
    try {
      return DateTime.parse(v);
    } catch (_) {
      return DateFormat('yyyy-mm').parse(v);
    }
  } else if (permissive && v is int) {
    if (v >= 0) {
      return DateTime.fromMillisecondsSinceEpoch(v, isUtc: true);
    } else {
      throw ArgumentError('Illegal timestamp: $v');
    }
  } else {
    throw ArgumentError('Illegal type: ${v.runtimeType}');
  }
}
