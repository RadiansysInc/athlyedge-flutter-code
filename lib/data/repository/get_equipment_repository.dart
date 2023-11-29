import 'package:flutter/material.dart';
import 'package:flutter_project/app/utils/prefs_helper.dart';
import 'package:flutter_project/data/model/equipment_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetEquipmentRepository {

  var allEquipmentList = [
    EquipmentModel(
        id: 1,
        name: "Bodyweight",
        imagePath: "assets/images/equipment_image.png",
        isSelected: false
    ),
    EquipmentModel(
        id: 2,
        name: "Dumbbells",
        imagePath: "assets/images/equipment_image.png",
        isSelected: false
    ),
    EquipmentModel(
        id: 3,
        name: "Bands",
        imagePath: "assets/images/equipment_image.png",
        isSelected: false
    ),
    EquipmentModel(
        id: 4,
        name: "Bodyweight",
        imagePath: "assets/images/equipment_image.png",
        isSelected: false
    ),
    EquipmentModel(
        id: 5,
        name: "Dumbbells",
        imagePath: "assets/images/equipment_image.png",
        isSelected: false
    ),
    EquipmentModel(
        id: 6,
        name: "Bands",
        imagePath: "assets/images/equipment_image.png",
        isSelected: false
    )
  ];

  Future<List<EquipmentModel>> getEquipmentList(PreferenceHelper helper) async {
    for (var element in allEquipmentList) {
      element.isSelected = false;
      element.isSelected = helper.equipmentList.contains(element.id.toString());
    }
    return allEquipmentList;
  }
}