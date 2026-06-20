import 'package:junior_football/core/error_handling/result.dart';

import 'handle_exception.dart';

Future<Result<T>> executeApi<T>(Future<T> Function() callApi) async {
  try {
    var result = await callApi.call();
    return Success(result);
  } on Exception catch (e) {
    return Failure(NetworkException.getMessageError(e));
  }
}
