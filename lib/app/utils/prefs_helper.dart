import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  final SharedPreferences _sharedPreference;

  // constructor
  PreferenceHelper(this._sharedPreference);

  Future<bool> saveEquipID(String value) async {
    List<String> equipmentIds = [...equipmentList, value];
    return _sharedPreference.setStringList("selected_equipment", equipmentIds);
  }

  Future<bool> removeEquipID(String value) async {
    List<String> equipmentIds = equipmentList;
    equipmentIds.removeWhere((element) => element == value);
    return _sharedPreference.setStringList("selected_equipment", equipmentIds);
  }

  List<String> get equipmentList =>
      _sharedPreference.getStringList("selected_equipment") ?? [];
}
