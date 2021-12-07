import 'api_request.dart';

class PatchRequest extends ApiRequest {
  PatchRequest(
    String urlSuffix, {
    Map<String, dynamic> payload = const <String, dynamic>{},
  }) : super(urlSuffix, payload);

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'RequestType': 'PATCH'};
  }

  @override
  String getRequestType() {
    return 'PATCH';
  }
}
