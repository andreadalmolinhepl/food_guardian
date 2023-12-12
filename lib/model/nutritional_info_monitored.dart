enum NutritionalInfoMonitored {
  vegetarian,
  vegan,
  palmoil
}

extension NutritionalInfoString on NutritionalInfoMonitored {
  String get stringValue {
    switch (this) {
      case NutritionalInfoMonitored.vegetarian:
        return 'Vegetarian';
      case NutritionalInfoMonitored.vegan:
        return 'Vegan';
      case NutritionalInfoMonitored.palmoil:
        return 'Palm-oil';
      default:
        return '';
    }
  }
}