enum FoodRestrictionTypes {
  allergies,
  intolerances,
  sensitivities
}

extension FoodRestrictionTypesString on FoodRestrictionTypes {
  String get stringValue {
    switch (this) {
      case FoodRestrictionTypes.allergies:
        return 'Allergies';
      case FoodRestrictionTypes.intolerances:
        return 'Intolerances';
      case FoodRestrictionTypes.sensitivities:
        return 'Sensitivities';
      default:
        return '';
    }
  }
}