import '../entitites/entities.dart';

class Macros {
  int calories;
  int protein;
  int fat;
  int carbs;

  Macros({
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.protein,
  });

  MacrosEntity toEntity() {
    return MacrosEntity(
        calories: calories, carbs: carbs, fat: fat, protein: protein);
  }

  static Macros fromEntity(MacrosEntity entity) {
    return Macros(
        calories: entity.calories,
        carbs: entity.carbs,
        fat: entity.fat,
        protein: entity.protein);
  }
}
