import 'package:flutter/material.dart';
import 'package:flutter_project/data/model/equipment_model.dart';

class EquipmentCard extends StatelessWidget {
  final EquipmentModel equipmentModel;
  const EquipmentCard({super.key, required this.equipmentModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 90,
            width: 100,
            child: Stack(
              children: [
                Positioned.fill(
                    child: Image.asset(equipmentModel.imagePath ?? "assets/images/equipment_image.png")),
                Positioned(
                    bottom: 10,
                    right: 15,
                    child: Image.asset(
                      equipmentModel.isSelected == true ? "assets/images/checked.png" : "assets/images/unchecked.png",
                      height: 13,
                      width: 13,
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 7,
          ),
           Text(
            equipmentModel.name ?? "NA",
            style: const TextStyle(color: Colors.white, fontSize: 12),
          )
        ],
      ),
    );
  }
}
