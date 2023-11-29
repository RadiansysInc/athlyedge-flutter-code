import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/app/di/injector.dart';
import 'package:flutter_project/app/utils/prefs_helper.dart';
import 'package:flutter_project/data/bloc/state/equipment_state.dart';
import 'package:flutter_project/data/model/equipment_model.dart';
import 'package:flutter_project/data/repository/get_equipment_repository.dart';
import 'package:flutter_project/data/repository/save_equipment_repository.dart';

class EquipmentCubit extends Cubit<EquipmentState> {
  final GetEquipmentRepository _equipmentRepository;
  final ActionEquipmentRepository _actionEquipmentRepository;
  final prefs = injector<PreferenceHelper>();

  EquipmentCubit(this._equipmentRepository, this._actionEquipmentRepository)
      : super(const EquipmentState.init());

  void fetchEquipmentList(
      {bool refresh = false, bool showLoading = true}) async {
    if (showLoading) {
      emit(const EquipmentState.loading());
      await Future.delayed(const Duration(seconds: 1));
    }
    emit(EquipmentState.success(
        await _equipmentRepository.getEquipmentList(prefs)));
  }

  void updateEquipmentData(EquipmentModel equipData) async {
    if (equipData.isSelected == true) {
      log("remove::::${equipData.isSelected}");
      await _actionEquipmentRepository.removeEquipment(
          prefs, equipData.id.toString());
    } else {
      if (prefs.equipmentList.length >= 3) {
        emit(const EquipmentState.error(
            "You can select up-to only 3 equipment."));
      } else {
        log("save::::${equipData.isSelected}");
        await _actionEquipmentRepository.saveEquipment(
            prefs, equipData.id.toString());
      }
    }
    emit(EquipmentState.success(
        await _equipmentRepository.getEquipmentList(prefs)));
  }
}
