
import 'package:flutter_sample_app/core/local/shared_preference/app_preference.dart';
import 'package:get_it/get_it.dart';

class Injector {
  static GetIt instance = GetIt.instance;

  Injector._();

  static void init() {
    instance.registerLazySingleton<AppPreference>(() => AppPreferenceImp());
  }

  static void reset() {
    instance.reset();
  }

  static void resetLazySingleton() {
    instance.resetLazySingleton();
  }
}
