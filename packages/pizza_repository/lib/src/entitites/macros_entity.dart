class MacrosEntity {
  double calories;
  double protein;
  double fat;
  double carbs;

  MacrosEntity({
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.protein,
  });

  Map<String, Object> toDocument() {
    return {
      "calories": calories,
      "protein": protein,
      "fat": fat,
      "carbs": carbs
    };
  }

  static MacrosEntity fromDocument(Map<String, dynamic> doc) {
    return MacrosEntity(
        calories: checkIsDouble(doc["calories"]),
        carbs: checkIsDouble(doc["carbs"]),
        fat: checkIsDouble(doc["fat"]),
        protein: checkIsDouble(doc["protein"]));
  }

  static double checkIsDouble(dynamic val) {
    return (val is int) ? val.toDouble() : val;
  }
}
