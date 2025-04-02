enum ObjectType { SPORT_FACILITY, TRAINING_SESSION, COACH }

extension ObjectTypeMapper on String? {
  ObjectType toObjectType() {
    switch (this) {
      case "SPORT_FACILITY":
        return ObjectType.SPORT_FACILITY;
      case "TRAINING_SESSION":
        return ObjectType.TRAINING_SESSION;
      case "COACH":
        return ObjectType.COACH;
      default:
        return ObjectType.SPORT_FACILITY;
    }
  }
}
