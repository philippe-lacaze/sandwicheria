import 'package:flutter/material.dart';
import 'package:sandwicheria/core/models/commande.dart';
import 'package:sandwicheria/ui/menu_view.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderCommanderView extends StatefulWidget {
  @override
  _FormBuilderCommanderViewState createState() => _FormBuilderCommanderViewState();
}

class _FormBuilderCommanderViewState extends State<FormBuilderCommanderView> {
  final GlobalKey<FormBuilderState> _formKey =
      new GlobalKey<FormBuilderState>();
  bool isFormChanged = false;

  Commande commande = Commande();
    //..client = 'Philippe'
    //..menu = 'Pique-nique';

  @override
  Widget build(BuildContext context) {

    var _onChanged = (value) {
      //print("_formKey.currentState.value=${_formKey.currentState.value}");
      //print('value change=$value');
    };

    var _formValue = (String name) {
      var map =_formKey.currentState?.value;
      return (map != null) ? map[name] : null;
    };

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
              onChanged: _onChanged,
              child: Column(
                children: <Widget>[
                  FormBuilderTextField(
                    attribute: "client",
                    decoration: InputDecoration(labelText: "Client"),
                    onChanged: _onChanged,
                    autofocus: true,
                    initialValue: commande.client,
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  FormBuilderRadio(
                    decoration:
                        InputDecoration(labelText: 'Choisissez un menu'),
                    attribute: "menu",
                    leadingInput: true,
                    onChanged: _onChanged,
                    validators: [FormBuilderValidators.required()],
                    initialValue: commande.menu,
                    options: [
                      "Sandwich",
                      "Pique-nique",
                    ]
                        .map((val) => FormBuilderFieldOption(value: val))
                        .toList(growable: false),
                  ),

//                  Builder(
//                    builder: (context) {
//                      print('build');
//                      var map =_formKey.currentState?.value;
//                      var value = (map != null) ? map["menu"] : null;
//                      return value != null ? Text('Avec menu') : Text('Sans menu');
//                    },
//                  ),


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
  }
}
