import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class NetworkException {
  NetworkException._();

  static String getMessageError(Exception exception) {
    if (exception is DioException) {
      switch (exception.type) {
        case DioExceptionType.connectionTimeout:
          return 'errors.connectionTimeout'.tr();
        case DioExceptionType.sendTimeout:
          return 'errors.sendTimeout'.tr();
        case DioExceptionType.receiveTimeout:
          return 'errors.receiveTimeout'.tr();
        case DioExceptionType.badCertificate:
          return 'errors.badCertificate'.tr();
        case DioExceptionType.badResponse:
          return _handleMessageResponse(exception);
        case DioExceptionType.cancel:
          return 'errors.cancel'.tr();
        case DioExceptionType.connectionError:
          return 'errors.connectionError'.tr();
        case DioExceptionType.unknown:
          return 'errors.unknown'.tr();
      }
    } else {
      return exception.toString();
    }
  }

  static String _handleMessageResponse(DioException e) {
    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final data = e.response!.data;

      String? message;
      if (data is Map) {
        message = data['message']?.toString();
      }

      switch (statusCode) {
        case 400:
          return message ?? 'errors.badRequest'.tr();
        case 401:
          return (message != null) ? 'errors.error401'.tr() + message : 'errors.error401'.tr();
        case 403:
          return 'errors.error403'.tr();
        case 404:
          return message ?? 'errors.notFound'.tr();
        case 408:
          return 'errors.error408'.tr();
        case 429:
          return 'errors.error429'.tr();
        case 500:
          return 'errors.error500'.tr();
        case 502:
          return 'errors.error502'.tr();
        case 503:
          return 'errors.error503'.tr();
        case 504:
          return 'errors.error504'.tr();
        default:
          return message ?? 'Server error (${statusCode ?? 'unknown'}). Please try again.';
      }
    }
    return 'errors.defaultError'.tr();
  }
}
