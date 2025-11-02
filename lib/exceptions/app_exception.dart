abstract class AppException implements Exception {
  final String? message;

  AppException({this.message});
  @override
  String toString() {
    return message ?? 'error';
  }
}

class ParseException implements AppException {
  @override
  final String? message;
  ParseException({this.message});
}

class ApiException implements AppException {
  final int? statusCode;

  @override
  final String? message;
  ApiException({this.message, this.statusCode});

  @override
  String toString() {
    return '$message with statusCode $statusCode';
  }
}

class UnknownException implements AppException {
  @override
  final String? message;
  UnknownException({this.message});
}
