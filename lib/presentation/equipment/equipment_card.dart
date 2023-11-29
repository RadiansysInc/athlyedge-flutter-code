import 'package:flutter/material.dart';
import 'package:flutter_project/data/model/equipment_model.dart';

class EquipmentCard extends StatefulWidget {
  final EquipmentModel equipmentModel;
  final VoidCallback action;
  const EquipmentCard({super.key, required this.equipmentModel, required this.action});

  @override
  State<EquipmentCard> createState() => _EquipmentCardState();
}

class _EquipmentCardState extends State<EquipmentCard> {
  double height = 90.0;

  void _startBounceAnimation() {
    setState(() {
      height = 80.0; // Set the target height for the bounce animation
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        height = 90.0; // Reset the height after the bounce animation
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _startBounceAnimation();
        widget.action();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildBoxWithAnimation(),
            const SizedBox(
              height: 7,
            ),
            Text(
              widget.equipmentModel.name ?? "NA",
              style: const TextStyle(color: Colors.white, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBoxWithAnimation() {
    return  AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      curve: Curves.bounceOut, // Use the bounce curve for animation
      width: 100,
      height: height, // Height of the box animated with a bounce effect
      color: Colors.transparent,
      child:_buildEquipmentBanner(),
    );
  }

  Widget _buildEquipmentBanner() {
    return Stack(
      children: [
        Positioned.fill(
            child: Image.asset(widget.equipmentModel.imagePath ??
                "assets/images/equipment_image.png")),
        Positioned(
            bottom: 10,
            right: 15,
            child: Image.asset(
              widget.equipmentModel.isSelected == true
                  ? "assets/images/checked.png"
                  : "assets/images/unchecked.png",
              height: 13,
              width: 13,
            )),
      ],
    );
  }
}
