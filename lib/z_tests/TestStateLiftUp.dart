import 'package:flutter/material.dart';

class TestStateLiftUp extends StatefulWidget {
  @override
  _TestStateLiftUpState createState() => _TestStateLiftUpState();
}

class _TestStateLiftUpState extends State<TestStateLiftUp> {

  int _counter = 0;


  int get counter => _counter;

  set counter(int value) {
    setState(() {
      _counter = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TestStateLiftUp'),),
      body: Column(
        children: <Widget>[
          WidgetA(this),
          WidgetB(this),
          WidgetC(this),
        ],
      ),
    );
  }
}



class WidgetA extends StatelessWidget {

  _TestStateLiftUpState state;

  WidgetA(this.state);
 
  @override
  Widget build(BuildContext context) {
    print('WidgetA build');
    return RaisedButton(
      onPressed: () => state.counter = state.counter + 1,
    );
  }


}

class WidgetB extends StatelessWidget {

  _TestStateLiftUpState  state;

  WidgetB(this.state);

  @override
  Widget build(BuildContext context) {
    print('WidgetB build');
    return Text("counter ${state.counter}");
  }
}

class WidgetC extends StatelessWidget {

  _TestStateLiftUpState  state;

  WidgetC(this.state);

  @override
  Widget build(BuildContext context) {
    print('WidgetC build');
    return Text("WidgetC");
  }
}

