import 'package:dio/dio.dart';

abstract class Failure {
  final errMessage;
  Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);
  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection Timeout with API Server');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send Timeout with API Server');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Recevie Timeout with API Server');
      case DioExceptionType.badCertificate:
        return ServerFailure('Bad Certificate Timeout with API Server');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioError.response!.statusCode!, dioError.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('Request to API canceled');
      case DioExceptionType.connectionError:
        return ServerFailure('Connection Error');
      case DioExceptionType.unknown:
        if (dioError.message!.contains('SocketException')) {
          return ServerFailure('No Internet Connection');
        }
        return ServerFailure('Unexpected Error, Please try later!');
      default:
        return ServerFailure('Opps There was an Error, Try Again');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic respose) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 401) {
      return ServerFailure(respose['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure('Your Request Not Found, Please Try Later!');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server Error, Please Try Again Later');
    } else {
      return ServerFailure('Opps There was an error');
    }
  }
}
