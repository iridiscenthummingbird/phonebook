import 'api_request.dart';

class PutRequest extends ApiRequest {
  PutRequest(
    String urlSuffix, {
    Map<String, dynamic> payload = const <String, dynamic>{},
  }) : super(urlSuffix, payload);

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'RequestType': 'PUT'};
  }

  @override
  String getRequestType() {
    return 'PUT';
  }
}
