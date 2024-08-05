class MacrosEntity {
  int calories;
  int protein;
  int fat;
  int carbs;

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
        calories: doc["calories"],
        carbs: doc["carbs"],
        fat: doc["fat"],
        protein: doc["protein"]);
  }
}
