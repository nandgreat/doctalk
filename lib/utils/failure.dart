import 'dart:async';

import 'dart:io';

import 'package:doctalk/networking/AppException.dart';

class FailureException {
  final Exception _exception;

  FailureException(this._exception);

  String response() {
    switch (_exception.runtimeType) {
      case TimeoutException:
        return 'Network timeout!';
        break;
      case SocketException:
        return 'No internet connection 😑';
        break;
      case FormatException:
        return 'Bad response format.';
        break;
      case HttpException:
        return 'Couldn\'t find the post 😱';
        break;
      case UnauthorisedException:
        return "Unauthorized";
      default:
        return 'An unknown error has occurred!';
    }
  }
}
