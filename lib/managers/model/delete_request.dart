import 'api_request.dart';

class DeleteRequest extends ApiRequest {
  DeleteRequest(
    String urlSuffix,
  ) : super(urlSuffix, <String, dynamic>{});

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'RequestType': 'DELETE'};
  }

  @override
  String getRequestType() {
    return 'DELETE';
  }
}
