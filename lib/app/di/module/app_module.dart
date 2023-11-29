import 'package:shared_preferences/shared_preferences.dart';

abstract class AppModule {
  static Future<SharedPreferences> provideSharedPreferences() {
    return SharedPreferences.getInstance();
  }
}