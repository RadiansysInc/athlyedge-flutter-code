
import 'package:flutter_project/data/model/equipment_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'equipment_state.freezed.dart';

@freezed
class EquipmentState with _$EquipmentState {
  const factory EquipmentState.init() = _Init;
  const factory EquipmentState.loading() = _Loading;
  const factory EquipmentState.success(List<EquipmentModel> data) = _Success;
  const factory EquipmentState.error(dynamic error) = _Error;
}