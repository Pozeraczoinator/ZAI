class Coach {
  int? id;
  String? name;
  String? surname;
  int? sportFacilitiesId;
  String? imageUrl;

  Coach({
    this.id,
    this.name,
    this.surname,
    this.sportFacilitiesId,
    this.imageUrl,
  });

  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      sportFacilitiesId: json['sportFacilitiesId'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'sportFacilitiesId': sportFacilitiesId,
      'imageUrl': imageUrl,
    };
  }
}
