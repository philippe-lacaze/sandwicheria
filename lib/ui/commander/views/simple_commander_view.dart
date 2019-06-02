import 'package:flutter/material.dart';
import 'package:sandwicheria/core/models/commande.dart';
import 'package:sandwicheria/ui/menu_view.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SimpleCommanderView extends StatefulWidget {
  @override
  _SimpleCommanderViewState createState() => _SimpleCommanderViewState();
}

class _SimpleCommanderViewState extends State<SimpleCommanderView> {
  final GlobalKey<FormBuilderState> _formKey =
      new GlobalKey<FormBuilderState>();
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
          FormField<String>(
            autovalidate: isFormChanged,
            onSaved: (value) => commande.client = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                var error = "Le client est requis";
                print(error);
                return error;
              }
            },
            initialValue: commande.client,
            builder: (FormFieldState<String> fieldState) => TextField(
                  autofocus: true,
                  onChanged: (value) {
                    print('TextField value change=$value');
                    fieldState.didChange(value);
                  },
                  decoration: InputDecoration(
                      hasFloatingPlaceholder: true,
                      border: OutlineInputBorder(),
                      helperText: "Le nom est requis",
                      labelText: "Nom du Client",
                      errorText: fieldState.errorText),
                ),
          ),

          Divider(),

//                TextFormField(
//                  autofocus: true,
//                  autovalidate: isFormChanged,
//                  initialValue: commande.client,
//                  decoration: InputDecoration(
//                    hasFloatingPlaceholder: true,
//                    border: OutlineInputBorder(),
//                    helperText: "Le nom est requis",
//                    labelText: "Nom du client",
//                    //hintText: "Nom du client",
//                  ),
//                  validator: (value) {
//                    if (value == null || value.isEmpty) {
//                      var error = "Le client est requis";
//                      //print(error);
//                      return error;
//                    }
//                  },
//                  onSaved: (value) {
//                    commande.client = value;
//                    //print('save client=$value');
//                  },
//                ),
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

                  Builder(
                    builder: (context) {
                      print('build');
                      var map =_formKey.currentState?.value;
                      var value = (map != null) ? map["menu"] : null;
                      return value != null ? Text('Avec menu') : Text('Sans menu');
                    },
                  ),


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
