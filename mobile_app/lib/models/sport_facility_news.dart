class SportFacilityNews {
  int id;
  int sportFacilitiesId;
  String title;
  String description;
  String imageUrl;

  SportFacilityNews({
    required this.id,
    required this.sportFacilitiesId,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory SportFacilityNews.fromJson(Map<String, dynamic> json) {
    return SportFacilityNews(
      id: json['id'] ?? -1,
      sportFacilitiesId: json['sportFacilityId'] ?? -1,
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      imageUrl: json['imageUrl'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sportFacilitiesId'] = sportFacilitiesId;
    data['title'] = title;
    data['description'] = description;
    data['imageUrl'] = imageUrl;

    return data;
  }
}
