class SportEquipment {
  int? id;
  String? type;
  String? brand;
  String? model;
  String? description;
  String? imageUrl;
  int? amount;

  SportEquipment({
    this.id,
    this.type,
    this.brand,
    this.model,
    this.description,
    this.imageUrl,
    this.amount,
  });

  factory SportEquipment.fromJson(Map<String, dynamic> json) {
    return SportEquipment(
      id: json['id'],
      type: json['type'],
      brand: json['brand'],
      model: json['model'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'brand': brand,
      'model': model,
      'description': description,
      'imageUrl': imageUrl,
      'amount': amount,
    };
  }
}
