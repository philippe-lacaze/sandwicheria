import 'package:flutter/material.dart';

class StepperExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppScreenMode();
  }
}

class MyData {
  String name = '';
  String phone = '';
  String email = '';
  String age = '';
  String menu = '';

  @override
  String toString() {
    return 'MyData{name: $name, phone: $phone, email: $email, age: $age, menu: $menu}';
  }

}

class MyAppScreenMode extends State<StepperExample> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: new ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Steppers'),
          ),
          body: new StepperBody(),
        ));
  }
}

class StepperBody extends StatefulWidget {
  @override
  _StepperBodyState createState() => new _StepperBodyState();
}

class _StepperBodyState extends State<StepperBody> {
  int currStep = 0;
  static var _focusNode = new FocusNode();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  static MyData data = new MyData();
  List<Step> steps;

  var _stepAge_active = true;
  var _stepAge_state  = StepState.disabled;

  void _iniStepper() {

    Step stepAge = new Step(
        title: const Text('Age'),
        // subtitle: const Text('Subtitle'),
        isActive: _stepAge_active,
        state: _stepAge_state,
        content: new TextFormField(
          keyboardType: TextInputType.number,
          autocorrect: false,
          validator: (value) {
            if (value.isEmpty || value.length > 2) {
              return 'Please enter valid age';
            }
          },
          maxLines: 1,
          onSaved: (String value) {
            data.age = value;
          },
          decoration: new InputDecoration(
              labelText: 'Enter your age',
              hintText: 'Enter age',
              icon: const Icon(Icons.explicit),
              labelStyle:
              new TextStyle(decorationStyle: TextDecorationStyle.solid)),
        ));
    var stepMenu = new Step(
        title: Text('Menu'),
        isActive: true,
        //state: StepState.error,
        state: StepState.indexed,
        content: Column(
          children: <Widget>[
            RadioListTile<String>(
              title: const Text('Lafayette'),
              value: 'lafayette',
              groupValue: data.menu,
              onChanged: (String value) {
                setState(() {
                  data.menu = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Thomas Jefferson'),
              value: 'jefferson',
              groupValue: data.menu,
              onChanged: (String value) {
                setState(() {
                  data.menu = value;
                });
              },
            ),
          ],
        ));
    steps = [
      //stepMenu,
      new Step(
          title: const Text('Name'),
          //subtitle: const Text('Enter your name'),
          isActive: true,
          //state: StepState.error,
          state: StepState.indexed,
          content: new TextFormField(
            focusNode: _focusNode,
            keyboardType: TextInputType.text,
            autocorrect: false,
            onSaved: (String value) {
              data.name = value;
            },
            maxLines: 1,
            //initialValue: 'Aseem Wangoo',
            validator: (value) {
              if (value.isEmpty || value.length < 1) {
                return 'Please enter name';
              }
            },
            decoration: new InputDecoration(
                labelText: 'Enter your name',
                hintText: 'Enter a name',
                //filled: true,
                icon: const Icon(Icons.person),
                labelStyle:
                new TextStyle(decorationStyle: TextDecorationStyle.solid)),
          )),
      new Step(
          title: const Text('Phone'),
          //subtitle: const Text('Subtitle'),
          isActive: true,
          //state: StepState.editing,
          state: StepState.indexed,
          content: new TextFormField(
            keyboardType: TextInputType.phone,
            autocorrect: false,
            validator: (value) {
              if (value.isEmpty || value.length < 10) {
                return 'Please enter valid number';
              }
            },
            onSaved: (String value) {
              data.phone = value;
            },
            maxLines: 1,
            decoration: new InputDecoration(
                labelText: 'Enter your number',
                hintText: 'Enter a number',
                icon: const Icon(Icons.phone),
                labelStyle:
                new TextStyle(decorationStyle: TextDecorationStyle.solid)),
          )),
      new Step(
          title: const Text('Email'),
          // subtitle: const Text('Subtitle'),
          isActive: true,
          state: StepState.indexed,
          // state: StepState.disabled,
          content: new TextFormField(
            autovalidate: true,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            validator: (value) {
              if (value.isEmpty || !value.contains('@')) {
                return 'Please enter valid email';
              } else {
                var future = new Future.delayed(
                    const Duration(milliseconds: 10), () =>
                    setState(() {
                      _stepAge_active = true;
                      _stepAge_state = StepState.indexed;
                    })
                );
              }
            },
            onSaved: (String value) {
              data.email = value;
            },
            maxLines: 1,
            decoration: new InputDecoration(
                labelText: 'Enter your email',
                hintText: 'Enter a email address',
                icon: const Icon(Icons.email),
                labelStyle:
                new TextStyle(decorationStyle: TextDecorationStyle.solid)),
          )),
      stepAge

      // new Step(
      //     title: const Text('Fifth Step'),
      //     subtitle: const Text('Subtitle'),
      //     isActive: true,
      //     state: StepState.complete,
      //     content: const Text('Enjoy Step Fifth'))
    ];
  }

  @override
  void initState() {
    super.initState();
    _iniStepper();
    _focusNode.addListener(() {
      setState(() {});
      print('Has focus: $_focusNode.hasFocus');
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Stepper builds... $steps');

    void showSnackBarMessage(String message,
        [MaterialColor color = Colors.red]) {
      Scaffold.of(context)
          .showSnackBar(new SnackBar(content: new Text(message)));
    }

    void _submitDetails() {
      final FormState formState = _formKey.currentState;

      if (!formState.validate()) {
        showSnackBarMessage('Please enter correct data');
      } else {
        formState.save();
        print("Name: ${data.name}");
        print("Phone: ${data.phone}");
        print("Email: ${data.email}");
        print("Age: ${data.age}");

        showDialog(
            context: context,
            child: new AlertDialog(
              title: new Text("Details"),
              //content: new Text("Hello World"),
              content: new SingleChildScrollView(
                child: new ListBody(
                  children: <Widget>[
                    new Text("Name : " + data.name),
                    new Text("Phone : " + data.phone),
                    new Text("Email : " + data.email),
                    new Text("Age : " + data.age),
                  ],
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
      }
    }

    return new Container(
        child: new Form(
          key: _formKey,
          child: new ListView(children: <Widget>[

            Text('data = $data'),

            new Stepper(
              steps: steps,
              type: StepperType.vertical,
              currentStep: this.currStep,
              onStepContinue: () {
                setState(() {
                  if (currStep < steps.length - 1) {
                    currStep = currStep + 1;
                  } else {
                    currStep = 0;
                  }
                  // else {
                  // Scaffold
                  //     .of(context)
                  //     .showSnackBar(new SnackBar(content: new Text('$currStep')));

                  // if (currStep == 1) {
                  //   print('First Step');
                  //   print('object' + FocusScope.of(context).toStringDeep());
                  // }

                  // }
                });
              },
              onStepCancel: () {
                setState(() {
                  if (currStep > 0) {
                    currStep = currStep - 1;
                  } else {
                    currStep = 0;
                  }
                });
              },
              onStepTapped: (step) {
                setState(() {
                  currStep = step;
                });
              },
            ),
            new RaisedButton(
              child: new Text(
                'Save details',
                style: new TextStyle(color: Colors.white),
              ),
              onPressed: _submitDetails,
              color: Colors.blue,
            ),
          ]),
        ));
  }
}
