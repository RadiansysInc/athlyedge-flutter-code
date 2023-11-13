import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/data/bloc/state/equipment_state.dart';
import 'package:flutter_project/data/model/equipment_model.dart';
import 'package:flutter_project/data/repository/get_equipment_repository.dart';
import 'package:flutter_project/data/repository/save_equipment_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EquipmentCubit extends Cubit<EquipmentState> {
  final GetEquipmentRepository _equipmentRepository;
  final ActionEquipmentRepository _actionEquipmentRepository;

  EquipmentCubit(this._equipmentRepository, this._actionEquipmentRepository)
      : super(const EquipmentState.init());

  void fetchEquipmentList(
      {bool refresh = false, bool showLoading = true}) async {
    if (showLoading) {
      emit(const EquipmentState.loading());
      await Future.delayed(const Duration(seconds: 1));
    }
    emit(EquipmentState.success(await _equipmentRepository.getEquipmentList()));
  }

  void updateEquipmentData(EquipmentModel equipData, context) async {
    if (equipData.isSelected == true) {
      await _actionEquipmentRepository.removeEquipment(equipData.id.toString());
      emit(const EquipmentState.init());
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> equipmentIds =
          prefs.getStringList("selected_equipment") ?? [];
      if (equipmentIds.length >= 3) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "You can select up-to only 3 equipment.",
          ),
          backgroundColor: Colors.deepOrangeAccent,
        ));
      } else {
        await _actionEquipmentRepository.saveEquipment(equipData.id.toString());
        emit(const EquipmentState.init());
      }
    }
  }
}
