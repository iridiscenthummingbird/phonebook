import 'api_request.dart';

class PostRequest extends ApiRequest {
  PostRequest(
    String urlSuffix, {
    Map<String, dynamic> payload = const <String, dynamic>{},
  }) : super(urlSuffix, payload);

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'RequestType': 'POST'};
  }

  @override
  String getRequestType() {
    return 'POST';
  }
}
