import '../entitites/entities.dart';
import 'models.dart';


class Pizza {
  String pizzaId;
  String picture;
  bool isVeg;
  int spicyLevel;
  String name;
  String description;
  double price;
  double discount;
  Macros macros;

  Pizza(
      {required this.pizzaId,
      required this.picture,
      required this.isVeg,
      required this.spicyLevel,
      required this.name,
      required this.description,
      required this.price,
      required this.discount,
      required this.macros});

  PizzaEntity toEntity() {
    return PizzaEntity(
        pizzaId: pizzaId,
        description: description,
        discount: discount,
        isVeg: isVeg,
        macros: macros,
        name: name,
        picture: picture,
        price: price,
        spicyLevel: spicyLevel);
  }

  static Pizza fromEntity(PizzaEntity entity) {
    return Pizza(
        pizzaId: entity.pizzaId,
        picture: entity.picture,
        isVeg: entity.isVeg,
        spicyLevel: entity.spicyLevel,
        name: entity.name,
        description: entity.description,
        discount: entity.discount,
        price: entity.price,
        macros: entity.macros);
  }
}
