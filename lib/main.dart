import 'package:flutter/material.dart';
import 'package:sandwicheria/core/models/commande.dart';
import 'package:sandwicheria/core/services/commande_service.dart';
import 'package:sandwicheria/locator.dart';
import 'package:sandwicheria/router.dart';
import 'package:sandwicheria/ui/theme/my_theme.dart';
import 'package:sandwicheria/ui/widgets/gradient_app_bar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('fr'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'La Sandwicheria',
      theme: MyTheme.defaultLightTheme,
      initialRoute: 'commanderStepper',
      onGenerateRoute: Router.generateRoute,
    );
  }
}

//
//class DisplayJsonSSECommande extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('La sandwicheria'),
//      ),
//      body: Center(child: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          StreamBuilder<Commande>(
//              stream: locator<CommandeService>().fetchSSE(),
//              builder: (BuildContext context,
//                  AsyncSnapshot<Commande> snapshot) {
//                if (snapshot.connectionState == ConnectionState.done) {
//                  if (snapshot.hasError) {
//                    print('Error = ${snapshot.error}');
//                    return Text('Error = ${snapshot.error}');
//                  } else {
//                    print('Data = ${snapshot.data}');
//                    return Text('Data = ${snapshot.data}');
//                  }
//                } else {
//                  print('Waiting...');
//                  return CircularProgressIndicator();
//                }
//              })
//        ],
//      )),
//    );
//  }
//}

class DisplayJsonListCommande extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('La sandwicheria'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FutureBuilder<List<Commande>>(
              future: locator<CommandeService>().fetchAll(),
              initialData: [],
              builder: (BuildContext context,
                  AsyncSnapshot<List<Commande>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    print('Error = ${snapshot.error}');
                    return Text('Error = ${snapshot.error}');
                  } else {
                    print('Data = ${snapshot.data}');
                    return Text('Data = ${snapshot.data}');
                  }
                } else {
                  print('Waiting...');
                  return CircularProgressIndicator();
                }
              })
        ],
      )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: Colors.red,
        backgroundColorEnd: primaryColorDark,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
