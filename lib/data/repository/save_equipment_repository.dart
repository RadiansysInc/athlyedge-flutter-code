
import 'dart:developer';

import 'package:flutter_project/app/utils/prefs_helper.dart';

class ActionEquipmentRepository {
  Future<bool> saveEquipment(PreferenceHelper helper, String equipId) async {
    return await helper.saveEquipID(equipId);
  }
  Future<bool> removeEquipment(PreferenceHelper helper, String equipId) async {
    log("removeEquipment::::");
    return await helper.removeEquipID(equipId);
  }
}