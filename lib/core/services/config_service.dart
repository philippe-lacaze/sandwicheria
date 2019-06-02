import 'package:sandwicheria/core/models/config_menu.dart';
import 'package:sandwicheria/core/models/config_plat.dart';

class ConfigService {
  static List<ConfigMenu> _menus = [
    ConfigMenu()
      ..id = 'sandwich'
      ..prix = '2,97 €'
      ..plats = [
        ConfigPlat()
          ..nom = 'un sandwich'
          ..pain = ['demi-baguette', 'pain de mie', 'pain suédois', 'du jour']
          ..ingredient = [
            'du jambon',
            'du poulet',
            'du saucisson',
            'du paté',
            'du fromage'
          ]
          ..accompagnements = [
            'beurre',
            'cornichon',
            'salade',
            'tomates',
            'mayonnaise',
            "huile d'olive"
          ]
          ..dessert = null
          ..complement = null
          ..boisson = null
      ],
    ConfigMenu()
      ..id = 'pique-nique'
      ..prix = '6,00 €'
      ..plats = [
        ConfigPlat()
          ..nom = 'un sandwich'
          ..pain = ['demi-baguette', 'pain de mie', 'pain suédois', 'du jour']
          ..ingredient = [
            'du jambon',
            'du poulet',
            'du saucisson',
            'du paté',
            'du fromage'
          ]
          ..accompagnements = [
            'beurre',
            'cornichon',
            'salade',
            'tomates',
            'mayonnaise',
            "huile d'olive"
          ]
          ..dessert = [
            'un fruit de saison',
            'un yaourt nature',
            'un yaourt aux fruits',
            'un dessert du jour'
          ]
          ..complement = [
            'un biscuit',
            'un yaourt nature',
            'un yaourt aux fruits'
          ]
          ..boisson = ["de l'eau plate", "de l'eau gazeuse"],
        ConfigPlat()
          ..nom = 'une salade'
          ..pain = null
          ..ingredient = [
            'du jambon',
            'du poulet',
            'du thon',
            'du fromage',
            'des oeufs'
          ]
          ..accompagnements = ['salade', 'tomates', 'crudités']
          ..dessert = [
            'un fruit de saison',
            'un yaourt nature',
            'un yaourt aux fruits',
            'un dessert du jour'
          ]
          ..complement = [
            'un biscuit',
            'un yaourt nature',
            'un yaourt aux fruits'
          ]
          ..boisson = ["de l'eau plate", "de l'eau gazeuse"],
        ConfigPlat()
          ..nom = 'un plat du jour'
          ..pain = null
          ..ingredient = null
          ..accompagnements = null
          ..dessert = [
            'un fruit de saison',
            'un yaourt nature',
            'un yaourt aux fruits',
            'un dessert du jour'
          ]
          ..complement = [
            'un biscuit',
            'un yaourt nature',
            'un yaourt aux fruits'
          ]
          ..boisson = ["de l'eau plate", "de l'eau gazeuse"]
      ]
  ];

  Future<List<ConfigMenu>> fetchMenus() async {
    return await _menus;
  }
}
