import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sandwicheria/core/models/commande.dart';
import 'package:sandwicheria/core/viewmodels/commander_stepper_model.dart';
import 'package:sandwicheria/ui/base_view.dart';
import 'package:sandwicheria/ui/commander/views/commander_form_fields.dart';

import 'package:sandwicheria/ui/commander/widgets/commande_action_bar.dart';
import 'package:sandwicheria/ui/menu_view.dart';
import 'package:sandwicheria/ui/theme/my_theme.dart';
import 'package:sandwicheria/ui/widgets/my_stepper.dart';
import 'package:sandwicheria/ui/widgets/the_app_bar.dart';

class CommanderMyStepperView extends StatefulWidget {
  @override
  CommanderMyStepperViewState createState() => CommanderMyStepperViewState();
}

class CommanderMyStepperViewState extends State<CommanderMyStepperView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CommanderStepperModel>(builder: (context, model, child) {
      final ThemeData _theme = Theme.of(context);
      return Scaffold(
          appBar: createAppBar(context),
          drawer: Drawer(
            child: Menu(),
          ),
          body: Builder(
            builder: (context) => ListView(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8),
                        ),
                        Icon(
                          Icons.event_note,
                          size: _theme.textTheme.title.fontSize + 8.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                        ),
                        Text(
                          "Créez votre commande",
                          style: _theme.textTheme.title,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 72.0),
                    child: Text(
                      "Sélectionnez les ingrédients étape par étape",
                      style: _theme.textTheme.subtitle,
                    ),
                  ),
                  Divider(),
                  Card(
                    elevation: 2.0,
                    child: _ceateFormBuilder(model, context, this),
                  ),
                ]),
          ));
    });
  }
}

_ceateFormBuilder(CommanderStepperModel model, BuildContext context,
    CommanderMyStepperViewState state) {
  print('CommanderStepperView._formBuilderPiqueNique');
  return FormBuilder(
      key: model.formKey,
      autovalidate: false,
      child: SingleChildScrollView(
          child: Theme(
              data: Theme.of(context).copyWith(
                primaryColor: primaryColorDark,
              ),
              child: _createStepper(model, context, state))));
}

_createStepper(CommanderStepperModel model, BuildContext context,
    CommanderMyStepperViewState state) {
  var index = 0;
  List<MyStep> mySteps = [
    MyStep(
        title: Text("Je choisi le menu"),
        subtitle: Text("${model.getFormValue('menu') ?? ''}"),
        content: menuField(model),
        isActive: true,
        state: _calcStepState("menu", model, index++)),
    MyStep(
        title: Text("Je choisi le plat"),
        subtitle: Text("${model.getFormValue('plat') ?? ''}"),
        content: platField(model),
        isActive: true,
        state: _calcStepState("plat", model, index++),
        condition: () {
          var plats = model.getPlats(model.choixMenu);
          var ok = model.choixMenu != null && plats != null && plats.length > 1;
          return ok;
        }),
    _createStepRadio("Je choisi le pain", "pain", model, index++),
    _createStepRadio(
        "Je choisi l'ingrédient principal", "ingredient", model, index++),
    _createStepCheckboxes(
        "Je choisi les accompagnements", "accompagnements", model, index++),
    _createStepRadio("Dessert", "dessert", model, index++),
    _createStepRadio("Je choisi le complément", "complement", model, index++),
    _createStepRadio("Je choisi la Boisson", "boisson", model, index++),
  ];

  List<MyStep> myStepsWithTermineStep = List.from(mySteps);
  myStepsWithTermineStep.add(MyStep(
      title: Text("Terminé"),
      condition: () => _isStepperCompleted(mySteps),
      state: MyStepState.editing,
      isActive: true,
      content: RaisedButton(
          child: Text('Passez commande'),
          onPressed: () {
            model.formKey.currentState.save();
            model.commande = Commande.fromJson(
                model.formKey.currentState.value);
            return Scaffold.of(context).showBottomSheet(
              (context) => CommanderActionBar(),
            );
          })));

  MyStepper stepper = MyStepper(
    key: model.stepperKey,
    type: MyStepperType.vertical,
    physics: PageScrollPhysics(),
    onStepTapped: model.gotoStep,
    currentStep: model.currentStep,
    onStepCancel: null,
    onStepContinue: null,
    controlsBuilder: (BuildContext context,
            {VoidCallback onStepContinue, VoidCallback onStepCancel}) =>
        Container(),
    mySteps: myStepsWithTermineStep,
  );

  model.stepperSize = stepper.mySteps.length;
  return stepper;
}

_isStepperCompleted(List<MyStep> steps) {
  var any = steps?.any((MyStep step) {
    if (step.condition != null && !step.condition()) {
      return false;
    } else {
      return (step.state != MyStepState.complete &&
          step.state != MyStepState.editing);
    }
  });

  print('any =$any');
  return !any;
}

_calcStepState(String name, CommanderStepperModel model, int index) {
  return model.currentStep == index
      ? MyStepState.editing
      : model.haveFormValue(name) ? MyStepState.complete : MyStepState.indexed;
}

MyStep _createStepRadio(
    String title, String name, CommanderStepperModel model, int index) {
  return MyStep(
      title: Text(title),
      subtitle: Text("${model.getFormValue(name) ?? ''}"),
      content: genericRadioField(name, model),
      isActive: true,
      state: _calcStepState(name, model, index),
      condition: () {
        return model.choixMenu != null &&
            model.haveOptionsPlat(model.choixMenu, model.choixPlat, name);
      });
}

MyStep _createStepCheckboxes(
    String title, String name, CommanderStepperModel model, int index) {
  return MyStep(
      title: Text(
        title,
      ),
      content: genericCheckboxesField(name, model),
      isActive: true,
      state: _calcStepState(name, model, index),
      condition: () {
        return model.choixMenu != null &&
            model.haveOptionsPlat(model.choixMenu, model.choixPlat, name);
      });
}
