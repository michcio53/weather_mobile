class ErrorDetail {
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
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ErrorDetail &&
        other.errorCode == errorCode &&
        other.message == message &&
        other.traceId == traceId &&
        other.timeStamp == timeStamp &&
        other.throwable == throwable &&
        other.stackTrace == stackTrace;
  }

  @override
  int get hashCode {
    return errorCode.hashCode ^
        message.hashCode ^
        traceId.hashCode ^
        timeStamp.hashCode ^
        throwable.hashCode ^
        stackTrace.hashCode;
  }
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
