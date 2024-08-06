import '../models/models.dart';
import 'entities.dart';

class PizzaEntity {
  String pizzaId;
  String picture;
  bool isVeg;
  int spicyLevel;
  String name;
  String description;
  double price;
  double discount;
  Macros macros;

  PizzaEntity({
    required this.pizzaId,
    required this.picture,
    required this.isVeg,
    required this.spicyLevel,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.macros,
  });

  Map<String, Object> toDocument() {
    return {
      "pizzaId": pizzaId,
      "picture": picture,
      "isVeg": isVeg,
      "spicyLevel": spicyLevel,
      "name": name,
      "description": description,
      "price": price,
      "discount": discount,
      "macros": macros.toEntity().toDocument()
    };
  }

  static PizzaEntity fromDocument(Map<String, dynamic> doc) {
    return PizzaEntity(
        pizzaId: doc["pizzaId"],
        picture: doc["picture"],
        isVeg: doc["isVeg"],
        spicyLevel: doc["spicyLevel"],
        name: doc["name"],
        description: doc["description"],
        price: checkIsDouble(doc["price"]),
        discount: checkIsDouble(doc["discount"]),
        macros: Macros.fromEntity(MacrosEntity.fromDocument(doc["macros"])));
  }

  static double checkIsDouble(dynamic val) {
    return (val is int) ? val.toDouble() : val;
  }
}
