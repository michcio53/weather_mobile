import 'package:equatable/equatable.dart';

class ErrorDetail extends Equatable {
  ErrorDetail({
    this.errorCode,
    this.message,
    this.traceId,
    this.timeStamp,
    this.throwable,
    this.stackTrace,
  });

  final String? errorCode;
  final String? message;
  final String? traceId;
  final DateTime? timeStamp;
  final Object? throwable;
  final StackTrace? stackTrace;

  @override
  List<Object?> get props => [
        errorCode,
        message,
        traceId,
        timeStamp,
        throwable,
        stackTrace,
      ];
}

class ErrorDetailFatal extends ErrorDetail {
  ErrorDetailFatal({
    Object? throwable,
    StackTrace? stackTrace,
  }) : super(
          throwable: throwable,
          stackTrace: stackTrace,
          errorCode: 'fatal',
        );
}
