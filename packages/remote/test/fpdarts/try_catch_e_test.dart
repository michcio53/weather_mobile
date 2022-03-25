import 'package:fpdart/fpdart.dart';
import 'package:remote/fpdarts/try_catch_e.dart';
import 'package:test/test.dart';

void main() {
  test(
    'if error thrown it correctly maps it to left() value',
    () async {
      final task = await tryCatchE(
        () async {
          throw Exception();
        },
        (error, stackTrace) => TryCatchEnum.failure,
      ).run();

      expect(task, left(TryCatchEnum.failure));
    },
  );

  test(
    'if success  it correctly maps it to right() value',
    () async {
      final task = await tryCatchE(
        () async {
          return right(TryCatchEnum.success);
        },
        (error, stackTrace) => TryCatchEnum.failure,
      ).run();

      expect(task, right(TryCatchEnum.success));
    },
  );
}

enum TryCatchEnum {
  success,
  failure,
}
