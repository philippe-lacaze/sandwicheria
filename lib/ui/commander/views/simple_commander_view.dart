import 'package:flutter/material.dart';
import 'package:sandwicheria/core/models/commande.dart';
import 'package:sandwicheria/ui/menu_view.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SimpleCommanderView extends StatefulWidget {
  @override
  _SimpleCommanderViewState createState() => _SimpleCommanderViewState();
}

class _SimpleCommanderViewState extends State<SimpleCommanderView> {
  final GlobalKey<FormState> _formKey =
      new GlobalKey<FormState>();
  bool isFormChanged = false;

  Commande commande = Commande();
    //..client = 'Philippe'
    //..menu = 'Pique-nique';

  @override
  Widget build(BuildContext context) {
    var _radioMenu = FormField<String>(
        autovalidate: isFormChanged,
        onSaved: (value) {
          commande.menu = value;
          print('onSave menu=$value');
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            var error = "Le menu est requis";
            print(error);
            return error;
          }
        },
        initialValue: commande.menu,
        builder: (FormFieldState<String> fieldState) {
          var _groupValue = fieldState.value;
          return Column(children: [
            RadioListTile(
              title: Text("Sandwich"),
              groupValue: _groupValue,
              value: "Sandwich",
              onChanged: (value) {
                print('radio value change $value');
                fieldState.didChange(value);
              },
            ),
            RadioListTile(
              title: Text("Pique-nique"),
              groupValue: _groupValue,
              value: "Pique-nique",
              onChanged: (value) {
                print('radio value change $value');
                fieldState.didChange(value);
              },
            ),
          ]);
        });

    var _classicForm = Form(
      key: _formKey,
      autovalidate: true,
      onChanged: () {
        print('Form changed');
        this.isFormChanged = true;
        setState(() {});
      },
      child: Column(
        children: <Widget>[

          TextFormField(

            autovalidate: isFormChanged,
            initialValue: commande.client,
            decoration: InputDecoration(
              hasFloatingPlaceholder: true,

              border: OutlineInputBorder(),
              helperText: "Le nom est requis",
              labelText: "Nom du client",
              //hintText: "Nom du client",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                var error = "Le client est requis";
                //print(error);
                return error;
              }
            },
            onSaved: (value) {
              commande.client = value;
              //print('save client=$value');
            },
          ),

          Divider(
            height: 32.0,
          ),

          _radioMenu,

          RaisedButton(
            child: Text("Commander"),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                print('form saved $commande');
              } else {
                print('Invalid form !');
              }
            },
          )
        ],
      ),
    );


    return Scaffold(
        appBar: AppBar(
          title: Text("Commander"),
        ),
        drawer: Drawer(
          child: Menu(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _classicForm
        ));
  }
}
