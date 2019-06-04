import 'package:sandwicheria/core/models/commande.dart';
import 'package:sandwicheria/core/services/commande_service.dart';
import 'package:sandwicheria/core/services/config_service.dart';
import 'package:sandwicheria/locator.dart';

import 'base_model.dart';

class CommanderModel extends BaseModel {

  Commande _commande = new Commande();

  String _choixMenu;
  String _choixPlat;

  Map<String, bool> _initialChoixFaits = {
    "menu": false,
    "plat": false,
    "pain": false
  };

  Map<String, bool> _choixFaits;

  CommandeService _commanderService = locator<CommandeService>();
  ConfigService _configService = locator<ConfigService>();


  CommanderModel() {
    _razChoixAutres();
  }

  void _razChoixAutres() {
    choixFaits = Map.from(_initialChoixFaits);
  }

  String get choixMenu => _choixMenu;

  set choixMenu(String value) {
    _choixMenu = value;
    _razChoixAutres();
    notifyListeners();
  }

  String get choixPlat => _choixPlat;

  set choixPlat(String value) {
    _choixPlat = value;
    _razChoixAutres();
    notifyListeners();
  }

  Commande get commande => _commande;

  set commande(Commande value) {
    _commande = value;
  }

  CommandeService get commanderService => _commanderService;

  ConfigService get configService => _configService;

  Map<String, bool> get choixFaits => _choixFaits;

  set choixFaits(Map<String, bool> value) {
    _choixFaits = value;
    notifyListeners();
  }

  void setChoixFaits(String choix, bool value) {
    choixFaits[choix] = value;
    notifyListeners();
  }


}