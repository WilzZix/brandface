import 'package:equatable/equatable.dart';

import '../i18n/strings.g.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure(this.message, {this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  final dynamic errorData;

  const ServerFailure(super.message, {super.statusCode, this.errorData});

  @override
  List<Object?> get props => [message, statusCode, errorData];
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class ParsingFailure extends Failure {
  const ParsingFailure(super.message);
}

extension FailureLocalization on Failure {
  String get localized {
    final texts = t.errors;

    if (this is NetworkFailure) return texts.network;
    if (this is ParsingFailure) return texts.parsing;

    if (this is ServerFailure) {
      final f = this as ServerFailure;

      if (f.message == 'USER_ALREADY_EXISTS') {
        return texts.server.userExists;
      }

      switch (f.statusCode) {
        case 400:
          return texts.server.badRequest;
        case 401:
          return texts.server.unauthorized;
        case 404:
          return texts.server.notFound;
        default:
          return texts.server.defaultMsg(
            code: f.statusCode?.toString() ?? '???',
          );
      }
    }

    return texts.unknown;
  }
}
