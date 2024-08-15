import 'package:dio/dio.dart';

import '../error/error_response.dart';

class CommonException {
  const CommonException();

  static ErrorResponse setError(error) {
    if (error is Exception) {
      if (error.runtimeType == DioException) {
        final dioError = error as DioException;
        final code = dioError.response?.statusCode.toString() ?? '9999';

        return ErrorResponse(
          status: 'Network ERROR',
          code: code,
          message: 'Your network is currently unavailable.\n Please try again later.',
        );
      } else {
        final code = '8888';

        return ErrorResponse(
          status: 'unExpected ERROR',
          code: code,
          message: 'Oops! Something went wrong.\n Please try again later.',
        );
      }
    } else {
      final code ='7777';

      return ErrorResponse(
        status: 'unKnown ERROR',
        code: code,
        message: 'Oops! Something went wrong.\n Please try again later.',
      );
    }
  }
}