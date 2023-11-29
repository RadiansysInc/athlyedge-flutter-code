import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/data/bloc/equipment_cubit.dart';
import 'package:flutter_project/data/bloc/state/equipment_state.dart';
import 'package:flutter_project/data/model/equipment_model.dart';
import 'package:flutter_project/presentation/equipment/equipment_card.dart';
import 'package:flutter_project/presentation/equipment/widgets/custom_button.dart';

class EquipmentListScreen extends StatefulWidget {
  const EquipmentListScreen({super.key});

  @override
  State<EquipmentListScreen> createState() => _EquipmentListScreenState();
}

class _EquipmentListScreenState extends State<EquipmentListScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      BlocProvider.of<EquipmentCubit>(context)
          .fetchEquipmentList(showLoading: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(39, 40, 42, 1),
      body: Column(
        children: [
          _buildWithBloc(),
          _buildAction(context)
        ],
      ),
    );
  }

  Widget _buildWithBloc() {
    return Expanded(
      child: Center(
        child: BlocConsumer<EquipmentCubit, EquipmentState>(
          listener: (context, state) {
            state.maybeMap(
                error: (msg) {
                  _showSnackBar(context,  msg.error, isError: true);
                }, orElse: () {});
          },
          builder: (context, state) {
            return state.when(
                init: () => const SizedBox.shrink(),
                loading: () => const CircularProgressIndicator(
                      color: Colors.white,
                      backgroundColor: Colors.amber,
                    ),
                success: (equipmentList) =>
                    _buildEquipList(context, equipmentList),
                error: (msg) => const SizedBox.shrink());
          },
        ),
      ),
    );
  }

  Widget _buildEquipList(
      BuildContext context, List<EquipmentModel> equipmentList) {
    return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 1.0,
        children: equipmentList
            .map((equipment) => EquipmentCard(
                action: () => BlocProvider.of<EquipmentCubit>(context)
                    .updateEquipmentData(equipment),
                  equipmentModel: equipment,
                ))
            .toList());
  }

  Widget _buildAction(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomButton(
              onPressed: () => BlocProvider.of<EquipmentCubit>(context)
                  .fetchEquipmentList(showLoading: true),
              title: 'Refresh'),
          CustomButton(
              onPressed: () => _showSnackBar(context, "Data Loaded"),
              title: 'Show message')
        ],
      ),
    );
  }

  _showSnackBar(BuildContext context, String message,
      {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }
}
