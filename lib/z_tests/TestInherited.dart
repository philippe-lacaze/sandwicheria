import 'package:flutter/material.dart';

class TestStateInherited extends StatefulWidget {
  @override
  _TestStateInheritedState createState() => _TestStateInheritedState();
}

class _TestStateInheritedState extends State<TestStateInherited> {

  int _counter = 0;

  int get counter => _counter;

  set counter(int value) {
    setState(() {
      _counter = value;
    });
  }

  var scaffold = Scaffold(
    appBar: AppBar(title: Text('TestStateInherited'),),
    body: Column(
      children: <Widget>[
        WidgetAA(),
        WidgetBB(),
        WidgetCC(),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {

    return MyInheritedWidget(
      data: this,
      child: scaffold,
    );
  }
}

class MyInheritedWidget extends InheritedWidget {

  final _TestStateInheritedState data;

  const MyInheritedWidget({ Key key, Widget child, this.data })
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static MyInheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(MyInheritedWidget);
  }


}



class WidgetAA extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    _TestStateInheritedState state = MyInheritedWidget.of(context).data;
    print('WidgetAA build');
    return RaisedButton(
      onPressed: () => state.counter = state.counter + 1,
    );
  }


}

class WidgetBB extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    _TestStateInheritedState state = MyInheritedWidget.of(context).data;
    print('WidgetBB build');
    return Text("counter ${state.counter}");
  }
}

class WidgetCC extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print('WidgetCC build');
    return Text("WidgetC");
  }
}

