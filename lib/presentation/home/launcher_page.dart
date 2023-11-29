import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/data/bloc/equipment_cubit.dart';
import 'package:flutter_project/data/repository/get_equipment_repository.dart';
import 'package:flutter_project/data/repository/save_equipment_repository.dart';
import 'package:flutter_project/presentation/equipment/equipment_list.dart';

class AppLauncherPage extends StatelessWidget {
  const AppLauncherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EquipmentCubit>(
      create: (_) => EquipmentCubit(GetEquipmentRepository(), ActionEquipmentRepository()),
      child: const EquipmentListScreen(),
    );
  }
}
