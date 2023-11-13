import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/data/bloc/equipment_cubit.dart';
import 'package:flutter_project/data/bloc/state/equipment_state.dart';
import 'package:flutter_project/presentation/equipment/equipment_card.dart';

class EquipmentListScreen extends StatelessWidget {
  const EquipmentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(39, 40, 42, 1),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: BlocBuilder<EquipmentCubit, EquipmentState>(
                builder: (context, state) {
                  return state.when(init: () {
                    context
                        .read<EquipmentCubit>()
                        .fetchEquipmentList(showLoading: false);
                    return const SizedBox.shrink();
                  }, loading: () {
                    return const CircularProgressIndicator(
                      color: Colors.white,
                      backgroundColor: Colors.amber,
                    );
                  }, success: (equipmentList) {
                    return GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        crossAxisSpacing: 1.0,
                        mainAxisSpacing: 1.0,
                        children: List.generate(equipmentList.length, (index) {
                          return InkWell(
                              onTap: () {
                                context
                                    .read<EquipmentCubit>()
                                    .updateEquipmentData(
                                        equipmentList[index], context);
                              },
                              child: EquipmentCard(
                                  equipmentModel: equipmentList[index]));
                        }));
                  }, error: (msg) {
                    return Text("Something went wrong: ${msg.toString()}");
                  });
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<EquipmentCubit>(context)
                        .fetchEquipmentList(showLoading: true);
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepOrangeAccent)),
                  child: const Text("Refresh")),
              ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        "Data Loaded.",
                      ),
                      backgroundColor: Colors.green,
                    ));
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepOrangeAccent)),
                  child: const Text("Show Message")),
            ],
          )
        ],
      ),
    );
  }
}
