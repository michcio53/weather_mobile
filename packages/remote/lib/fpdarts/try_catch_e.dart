import 'package:fpdart/fpdart.dart';

TaskEither<L, R> tryCatchE<L, R>(
  Future<Either<L, R>> Function() run,
  L Function(Object error, StackTrace stackTrace) onError,
) {
  return TaskEither<L, R>(
    () async {
      try {
        return await run();
        // ignore: avoid_catches_without_on_clauses
      } catch (error, stack) {
        return Left<L, R>(onError(error, stack));
      }
    },
  );
}
