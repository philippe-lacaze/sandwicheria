import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:sandwicheria/core/models/commande.dart';
import 'package:sandwicheria/core/viewmodels/commander_stepper_model.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:sandwicheria/ui/theme/my_theme.dart';
import 'package:sandwicheria/ui/util/utils.dart';

class CommanderActionBar extends StatefulWidget {
  const CommanderActionBar({
    Key key,
  }) : super(key: key);

  @override
  _CommanderActionBarState createState() => _CommanderActionBarState();
}

class _CommanderActionBarState extends State<CommanderActionBar> {
  var _alignement = Alignment.topLeft;
  var _text = "Votre commande";
  var _duration = 700;

  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    return Consumer<CommanderStepperModel>(
      builder: (BuildContext context, CommanderStepperModel model,
              Widget child) =>
          Container(
            constraints: BoxConstraints(minHeight: 300.0),
            margin: EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.indigo[600],
                  Colors.white,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AnimatedContainer(
                  duration: Duration(milliseconds: _duration),
                  curve: Curves.ease,
                  padding: const EdgeInsets.all(8.0),
                  alignment: _alignement,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      Icon(
                        Icons.send,
                        size: 32.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      Text(_text),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: ListTile(
                      isThreeLine: true,
                      leading: AnimatedImage(model.commande),
//                      Image.asset(
//                        getImageName(model.commande),
//                        width: 32.0,
//                        height: 32.0,
//                      ),
                      title: Text(
                        'Un menu ${model.commande.menu}',
                        style: TextStyle(color: secondaryDarkColor),
                      ),
                      subtitle: Text(
                        model.commande.articles(),
                        style: _theme.textTheme.subtitle,
                      ),
                    )

                    //Text(model.commande.articles(), style: _theme.textTheme.subtitle,),

                    ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: FormBuilderTextField(
                          decoration: InputDecoration(labelText: "Client"),
                          attribute: "client",
                          onChanged: (value) {
                            model.setFormValue("client", value);
                          },
                          validators: [FormBuilderValidators.required()],
                          initialValue: model.getFormValue("client"),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                      ),
                      Expanded(
                        child: FormBuilderDateTimePicker(
                          attribute: "date",
                          inputType: InputType.date,
                          format: DateFormat("dd/MM/yyyy"),
                          locale: Locale("fr"),
                          decoration: InputDecoration(labelText: "Date"),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Envoyer"),
                      //color: Colors.blueAccent,
                      onPressed: () {
                        model.formKey.currentState.save();
                        if (model.formKey.currentState.validate()) {
                          model.commande = Commande.fromJson(
                              model.formKey.currentState.value);
                          print("Commande =${model.commande}");
                          model.saveCommande();
                          setState(() {
                            _text = "";
                            _alignement = Alignment.topRight;
                          });
                          Future.delayed(Duration(milliseconds: _duration),
                              () => Navigator.of(context).pop());
                          Scaffold.of(context).showSnackBar(SnackBar(
                              duration: Duration(milliseconds: 3000),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0))),
                              content: Container(
                                height: 20.0,
                                margin: EdgeInsets.all(4.0),
                                padding: const EdgeInsets.all(2.0),
                                child: Center(
                                    child: Text(
                                        "Votre commande est enregistrée...")),
                              )));
                        }
                      },
                    ),
                    RaisedButton(
                      child: Text("Annuler"),
                      //color: Colors.blueGrey,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
    );
  }
}

class AnimatedImage extends StatefulWidget {
  Commande commande;

  AnimatedImage(this.commande) {}

  @override
  _AnimatedImageState createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage> {
  double _size = 32.0;
  double _marge = 1.0;
  double _delta = 20.0;

  _AnimatedImageState() {
    Future<void>.delayed(Duration(milliseconds: 10), () {
      setState(() => _marge = _delta - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      margin: EdgeInsets.only(
        top: _marge,
        bottom: _delta - _marge,
        //left: _marge,
        //right:  _delta - _marge
      ),
      height: _size,
      width: _size,
      curve: Curves.bounceOut,
      child: Image.asset(
        getImageName(widget.commande),
        width: _size,
        height: _size,
      ),
    );
  }
}
