
import 'package:shared_preferences/shared_preferences.dart';

class ActionEquipmentRepository {
  Future<bool> saveEquipment(String equipId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> equipmentIds = prefs.getStringList("selected_equipment") ?? [];
    equipmentIds.add(equipId);
    return await prefs.setStringList("selected_equipment", equipmentIds);
  }

  Future<bool> removeEquipment(String equipId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> equipmentIds = prefs.getStringList("selected_equipment") ?? [];
    equipmentIds.removeWhere((element) => element == equipId);
    return await prefs.setStringList("selected_equipment", equipmentIds);
  }
}