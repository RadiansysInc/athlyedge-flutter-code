
import 'package:flutter_project/app/di/module/app_module.dart';
import 'package:flutter_project/app/utils/prefs_helper.dart';
import 'package:flutter_project/data/repository/save_equipment_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector.registerSingletonAsync<SharedPreferences>(
          () => AppModule.provideSharedPreferences());

  injector.registerSingleton(
      PreferenceHelper(await injector.getAsync<SharedPreferences>()));

}