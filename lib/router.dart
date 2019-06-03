import 'package:flutter/material.dart';
import 'package:sandwicheria/ui/commander/views/form_builder_commander_view.dart';
import 'package:sandwicheria/ui/preparer/views/preparer_commandes_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
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
