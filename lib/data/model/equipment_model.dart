class EquipmentModel {
  int id;
  String? imagePath;
  String? name;
  bool? isSelected;

  EquipmentModel({
    required this.id,
    this.imagePath,
    this.name,
    this.isSelected,
  });

  factory EquipmentModel.fromJson(Map<String, dynamic> json) => EquipmentModel(
    id: json['id'],
    imagePath: json["imagePath"],
    name: json["name"],
    isSelected: json["is_selected"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "imagePath": imagePath,
    "name": name,
    "is_selected": isSelected,
  };
}
