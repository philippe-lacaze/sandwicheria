import 'package:sandwicheria/core/models/commande.dart';
import 'package:sandwicheria/core/services/commande_service.dart';
import 'package:sandwicheria/core/services/config_service.dart';
import 'package:sandwicheria/locator.dart';

import 'base_model.dart';

class CommanderModel extends BaseModel {

  Commande _commande = new Commande();

  String _choixMenu;
  String _choixPlat;

  Map<String, bool> _initialChoixAutres = {
    "pain": false
  };

  Map<String, bool> _choixAutres;

  CommandeService _commanderService = locator<CommandeService>();
  ConfigService _configService = locator<ConfigService>();


  CommanderModel() {
    _razChoixAutres();
  }

  void _razChoixAutres() {
    choixAutres = Map.from(_initialChoixAutres);
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

  Map<String, bool> get choixAutres => _choixAutres;

  set choixAutres(Map<String, bool> value) {
    _choixAutres = value;
    notifyListeners();
  }

  void setChoixAutres(String choix, bool value) {
    choixAutres[choix] = value;
    notifyListeners();
  }


}