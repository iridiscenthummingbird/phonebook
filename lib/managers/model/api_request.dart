import 'package:collection/collection.dart';

abstract class ApiRequest {
  final String urlSuffix;
  final Map<String, dynamic> payload;

  ApiRequest(this.urlSuffix, this.payload);

  Map<String, dynamic> toJson();

  String getRequestType();

  @override
  String toString() {
    return getRequestType() +
        " with payload  ${payload.toString().length > 300 ? payload.toString().substring(0, 300) + "..." : payload.toString()}";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApiRequest &&
          runtimeType == other.runtimeType &&
          urlSuffix == other.urlSuffix &&
          const MapEquality<String, dynamic>().equals(payload, other.payload);

  @override
  int get hashCode =>
      urlSuffix.hashCode ^ const MapEquality<String, dynamic>().hash(payload);
}
