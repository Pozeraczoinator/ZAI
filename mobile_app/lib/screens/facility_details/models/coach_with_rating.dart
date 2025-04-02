class CoachWithRating {
  int id;
  String name;
  String surname;
  String imageUrl;
  double? averageRating;
  //TODO traingins
  CoachWithRating(
      {required this.id,
      required this.averageRating,
      required this.imageUrl,
      required this.name,
      required this.surname});
}
