import 'package:domain/store/weather_store.dart';
import 'package:domain/usecase/use_case.dart';
import 'package:fpdart/fpdart.dart';
import 'package:remote/fpdarts/try_catch_e.dart';

enum SaveLocationIdFailure { unexpected }

class SaveLocationIdUseCase
    extends ParamUseCase<SaveLocationIdFailure, Unit, int> {
  SaveLocationIdUseCase({required WeatherStore weatherStore})
      : _weatherStore = weatherStore;

  final WeatherStore _weatherStore;

  @override
  TaskEither<SaveLocationIdFailure, Unit> execute({required int param}) {
    return tryCatchE(() async {
      final result = await _weatherStore.setWoeid(param);

      if (result) {
        return right(unit);
      } else {
        return left(SaveLocationIdFailure.unexpected);
      }
    }, (_, __) => SaveLocationIdFailure.unexpected);
  }
}
