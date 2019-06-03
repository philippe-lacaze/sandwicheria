import 'package:flutter/material.dart';
import 'package:sandwicheria/core/models/commande.dart';
import 'package:sandwicheria/core/viewmodels/commander_model.dart';
import 'package:sandwicheria/ui/base_view.dart';
import 'package:sandwicheria/ui/menu_view.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderCommanderView extends StatefulWidget {
  @override
  _FormBuilderCommanderViewState createState() =>
      _FormBuilderCommanderViewState();
}

class _FormBuilderCommanderViewState extends State<FormBuilderCommanderView> {
  final GlobalKey<FormBuilderState> _formKey =
      new GlobalKey<FormBuilderState>();

  bool _isFormChanged = false;

  _formValue(String name) {
    var map = _formKey.currentState?.value;
    return (map != null) ? map[name] : null;
  }

  _if({String name, Function condition, Widget child}) {
    var value = _formValue(name);
    var isOk = condition(value);
    return isOk ? child : Container();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CommanderModel>(
      builder: (context, model, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text("Commander"),
            ),
            drawer: Drawer(
              child: Menu(),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilder(
                  key: _formKey,
                  autovalidate: _isFormChanged,
                  onChanged: (_) => setState(() => _isFormChanged = true),
                  child: ListView(
                    children: <Widget>[
                      _clientField(model),
                      _menuField(model),
                      _if(
                          name: "menu",
                          condition: (value) => value != null,
                          child: Column(
                            children: <Widget>[_platField(model)],
                          )),
                      _if(
                          name: "plat",
                          condition: (value) => value != null,
                          child: Column(
                            children: <Widget>[_painField(model)],
                          )),

                      RaisedButton(
                        child: Text("Commander"),
                        onPressed: () {
                          _formKey.currentState.save();
                          if (_formKey.currentState.validate()) {
                            var commande =
                                Commande.fromJson(_formKey.currentState.value);
                            print("Commande = $commande");
                          } else {
                            print("validation failed");
                          }
                        },
                      )
                    ],
                  )),
            ));
      },
    );
  }
}

_clientField(CommanderModel model) => FormBuilderTextField(
      attribute: "client",
      decoration: InputDecoration(labelText: "Client"),
      autofocus: true,
      initialValue: model.commande.client,
      validators: [
        FormBuilderValidators.required(
            errorText: "Le nom du client est requis"),
      ],
    );

_menuField(CommanderModel model) => FormBuilderRadio(
      decoration: InputDecoration(labelText: 'Choisissez un menu'),
      attribute: "menu",
      leadingInput: true,
      onChanged: (value) {
        model.choixMenu = value;
      },
      validators: [FormBuilderValidators.required()],
      initialValue: model.commande.menu,
      options: model.configService
          .getMenus()
          .map((val) => FormBuilderFieldOption(value: val))
          .toList(growable: false),
    );

_platField(CommanderModel model) => FormBuilderRadio(
      decoration: InputDecoration(labelText: 'Choisissez un plat'),
      attribute: "plat",
      leadingInput: true,
      onChanged: (value) {
        model.choixPlat = value;
      },
      validators: [FormBuilderValidators.required()],
      initialValue: model.commande.plat,
      options: model.configService
          .getPlats(model.choixMenu)
          .map((val) => FormBuilderFieldOption(value: val))
          .toList(growable: false),
    );

_painField(CommanderModel model) => FormBuilderRadio(
  decoration: InputDecoration(labelText: 'Choisissez un pain'),
  attribute: "pain",
  leadingInput: true,
  onChanged: (value) {
    model.setChoixAutres("pain", true);
  },
  validators: [FormBuilderValidators.required()],
  initialValue: model.commande.pain,
  options: model.configService
      .getPains(model.choixMenu, model.choixPlat)
      .map((val) => FormBuilderFieldOption(value: val))
      .toList(growable: false),
);
