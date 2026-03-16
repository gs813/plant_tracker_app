class Plant {
  int? id;
  String name;
  String type;
  String watering;
  String note;

  Plant({
    this.id,
    required this.name,
    required this.type,
    required this.watering,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'watering': watering,
      'note': note,
    };
  }

  factory Plant.fromMap(Map<String, dynamic> map) {
    return Plant(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      watering: map['watering'],
      note: map['note'],
    );
  }
}