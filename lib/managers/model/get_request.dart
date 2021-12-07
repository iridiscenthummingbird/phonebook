import 'package:collection/collection.dart';

import 'api_request.dart';

class GetRequest extends ApiRequest {
  GetRequest(
    String urlSuffix, {
    Map<String, dynamic> payload = const <String, dynamic>{},
    this.queryParams = const <String, String>{},
  }) : super(urlSuffix, payload);

  final Map<String, String> queryParams;

  @override
  String get urlSuffix {
    if (queryParams.isNotEmpty == true) {
      final String encodedQuery = Uri(queryParameters: queryParams).query;
      final String url = '${super.urlSuffix}?$encodedQuery';
      return url;
    } else {
      return super.urlSuffix;
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'RequestType': 'GET'};
  }

  @override
  String getRequestType() {
    return 'GET';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is GetRequest &&
          runtimeType == other.runtimeType &&
          const MapEquality<String, dynamic>()
              .equals(queryParams, other.queryParams);

  @override
  int get hashCode =>
      super.hashCode ^ const MapEquality<String, dynamic>().hash(queryParams);
}
