import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sandwicheria/core/models/commande.dart';
import 'package:sandwicheria/core/services/commande_service.dart';
import 'package:sandwicheria/core/services/config_service.dart';
import 'package:sandwicheria/locator.dart';
import 'package:sandwicheria/ui/widgets/my_stepper.dart';

import 'base_model.dart';

class CommanderStepperModel extends BaseModel {
  final ConfigService configService = locator<ConfigService>();
  final CommandeService commandeService = locator<CommandeService>();

  final GlobalKey<FormBuilderState> formKey =
      new GlobalKey<FormBuilderState>();

  final UniqueKey stepperKey = UniqueKey();

  String _choixMenu;
  String _choixPlat;

  int _currentStep = 0;

  int stepperSize = 0;

  Commande commande;

  CommanderStepperModel() {
    print('new CommanderStepperModel()');
  }

  FormBuilderState getFormState() {
    return  formKey.currentState;
  }

  Map<String, dynamic> getFormValues() {
    var state = getFormState();
    print('model form state=$state');
    var values = getFormState()?.value;
    print('model getCurrentFormValues $values');
    return values;
  }

  dynamic getFormValue(String name) {
    Map<String, dynamic> values = getFormValues();
    return values != null ? getFormValues()[name] : null;
  }

  dynamic setFormValue(String name, dynamic value) {
    var map = getFormValues();
    if (map != null) {
      map[name] = value;
    } else {
      throw "model.setFormValue name=$name, value=$value, called but map = null";
    }
    return value;
  }

  int get currentStep => _currentStep;

  set currentStep(int value) {
    _currentStep = value;
    notifyListeners();
  }

  String get choixMenu => _choixMenu;

  set choixMenu(String value) {
    print('CommanderStepperModel set choixMenu=$value');
    _choixMenu = value;
    if (value == "sandwich") {
      setFormValue("plat", "sandwich");
      _choixPlat = "sandwich";
    }
    notifyListeners();
  }

  String get choixPlat => _choixPlat;

  set choixPlat(String value) {
    print('CommanderStepperModel set choixPlat=$value');
    _choixPlat = value;
    notifyListeners();
  }

  void nextStepDelayed([Duration delayed = const Duration(milliseconds: 300)]) {
    Future<void>.delayed(delayed).then((_) => nextStep());
  }

  int nextStep() {
    print('model nextStep current=$currentStep size=$stepperSize');
    if (currentStep + 1 < stepperSize) {
      return currentStep++;
    } else {
      notifyListeners();
      return currentStep;
    }
  }

  void gotoStep(int value) {
    currentStep = value;
  }

  List<String> getPlats(
      String menuId) {
    return this.configService.getPlats(menuId);
  }

  List<String> getOptionsPlat(
      String menuId, String nomPlat, String nomOptions) {
    return this.configService.getOptionsPlat(menuId, nomPlat, nomOptions);
  }

  bool haveOptionsPlat(String menuId, String nomPlat, String nomOptions) {
    return getOptionsPlat(menuId, nomPlat, nomOptions) != null;
  }

  bool haveFormValue(String name) {
    var val = getFormValue(name);
    print('model.haveFormValue name=$name value=$val');
    return val != null;
  }

  @override
  String toString() {
    return 'CommanderStepperModel{_choixMenu: $_choixMenu, _choixPlat: $_choixPlat, _currentStep: $_currentStep}';
  }

  void saveCommande() {
    commandeService.create(commande);
  }
}
