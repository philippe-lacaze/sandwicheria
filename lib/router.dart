import 'package:flutter/material.dart';
import 'package:sandwicheria/ui/commander/views/TestInherited.dart';
import 'package:sandwicheria/ui/commander/views/TestStateLiftUp.dart';
import 'package:sandwicheria/ui/commander/views/form_builder_commander_view.dart';
import 'package:sandwicheria/ui/commander/views/simple_commander_view.dart';
import 'package:sandwicheria/ui/preparer/views/preparer_commandes_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'TestState':
        return MaterialPageRoute(builder: (_) => TestStateLiftUp());
      case 'TestStateInherited':
        return MaterialPageRoute(builder: (_) => TestStateInherited());
      case 'commander':
        return MaterialPageRoute(builder: (_) => FormBuilderCommanderView());
      case 'preparer':
        return MaterialPageRoute(builder: (_) => PreparerCommandesView());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
              body:
                  Center(child: Text('No route defined for ${settings.name}')));
        });
    }
  }
}
