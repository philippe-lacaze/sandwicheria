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

  List<String> getMenus() {
    return _menus
        .map((ConfigMenu configMenu) => configMenu.id)
        .toList(growable: false);
  }

  List<String> getPlats(String menuId) {
    print("configService getPlats for menu $menuId");
    if (menuId == null) {
      return [];
    }
    ConfigMenu configMenu = getConfigMenu(menuId);
    List<String> plats = configMenu?.plats
            .map((ConfigPlat configPlat) => configPlat.nom)
            .toList(growable: false) ??
        [];
    print("configService getPlats = $plats");
    return plats;
  }

  ConfigMenu getConfigMenu(String menuId) {
    ConfigMenu configMenu = _menus.singleWhere(
        (ConfigMenu configMenu) => configMenu.id == menuId,
        orElse: null);
    return configMenu;
  }

  ConfigPlat getConfigPlat(String menuId, String nomPlat) {
    if (menuId == null || nomPlat == null) {
      return null;
    }
    ConfigMenu configMenu = getConfigMenu(menuId);
    if (configMenu == null) {
      return null;
    }
    return configMenu.plats.singleWhere((ConfigPlat configPlat) => configPlat.nom.contains(nomPlat), orElse: null);
  }


  List<String> getOptionsPlat(String menuId, String nomPlat, String nomOptions) {
    if (menuId == null || nomPlat == null) {
      return [];
    }
    ConfigPlat configPlat = getConfigPlat(menuId, nomPlat);
    if (configPlat == null) {
      return [];
    }
    return configPlat.getOptions(nomOptions);
  }
  
  List<String> getPains(String menuId, String nomPlat) {
    if (menuId == null || nomPlat == null) {
      return [];
    }
    ConfigPlat configPlat = getConfigPlat(menuId, nomPlat);
    if (configPlat == null) {
      return [];
    }
    return configPlat.pain;
  }
}
