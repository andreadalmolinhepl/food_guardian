enum AllergensList {
  milk,
  gluten,
  eggs,
  soya,
  nuts,
  fish,
  sulphurDioxideAndSulphites,
  mustard,
  celery,
  sesameSeeds,
  peanuts,
  crustaceans,
  molluscs,
  oats,
  lupins,
}

extension AllergensListString on AllergensList {
  String get stringValue {
    switch (this) {
      case AllergensList.milk:
        return 'Milk';
      case AllergensList.gluten:
        return 'Gluten';
      case AllergensList.eggs:
        return 'Eggs';
      case AllergensList.soya:
        return 'Soya';
      case AllergensList.nuts:
        return 'Nuts';
      case AllergensList.fish:
        return 'Fish';
      case AllergensList.sulphurDioxideAndSulphites:
        return 'Sulphur Dioxide and Sulphites';
      case AllergensList.mustard:
        return 'Mustard';
      case AllergensList.celery:
        return 'Celery';
      case AllergensList.sesameSeeds:
        return 'Sesame Seeds';
      case AllergensList.peanuts:
        return 'Peanuts';
      case AllergensList.crustaceans:
        return 'Crustaceans';
      case AllergensList.molluscs:
        return 'Molluscs';
      case AllergensList.oats:
        return 'Oats';
      case AllergensList.lupins:
        return 'Lupins';
      default:
        return '';
    }
  }
}