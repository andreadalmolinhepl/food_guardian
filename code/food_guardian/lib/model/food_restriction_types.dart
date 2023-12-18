enum FoodRestrictionTypes {
  allergies,
  intolerances,
  sensitivities
}

extension FoodRestrictionTypesString on FoodRestrictionTypes {
  String get stringValue {
    switch (this) {
      case FoodRestrictionTypes.allergies:
        return 'allergies';
      case FoodRestrictionTypes.intolerances:
        return 'intolerances';
      case FoodRestrictionTypes.sensitivities:
        return 'sensitivities';
      default:
        return '';
    }
  }
}