class AppException implements Exception {
  final String? message;
  final String? _prefix;

  AppException([this.message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$message';
  }
}

class NoInternetException {
  NoInternetException();
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, 'Error During Communication: ');
}

class BadRequestException extends AppException {
  final String errorCode;
  final String _errorMessage;
  final Map<String, dynamic> _errors;

  String get errorMessage =>
      _errors.isEmpty ? _errorMessage : _errors.toString();

  Map<String, dynamic> get errors => _errors;

  BadRequestException(this.errorCode, this._errorMessage, this._errors,
      [String? message])
      : super(
          message,
          'Invalid Request: ' +
              (_errors.isEmpty ? _errorMessage : _errors.toString()),
        );
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? message]) : super(message, 'Unauthorised: ');
}

class TooEarlyException extends AppException {
  final String errorCode;
  final String errorMessage;

  TooEarlyException(this.errorCode, this.errorMessage)
      : super('Too early: ', errorMessage);
}
