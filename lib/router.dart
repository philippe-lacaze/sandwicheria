import 'package:flutter/material.dart';
import 'package:sandwicheria/ui/administrer/administration_view.dart';
import 'package:sandwicheria/ui/preparer/views/preparer_commandes_bloc_view.dart';
import 'package:sandwicheria/z_tests/TestInherited.dart';
import 'package:sandwicheria/z_tests/TestStateLiftUp.dart';
import 'package:sandwicheria/ui/commander/views/commander_my_stepper_view.dart';
import 'package:sandwicheria/ui/preparer/views/preparer_commandes_view.dart';
import 'package:sandwicheria/z_scories/stepper_example.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'TestState':
        return MaterialPageRoute(builder: (_) => TestStateLiftUp());
      case 'TestStateInherited':
        return MaterialPageRoute(builder: (_) => TestStateInherited());
      case 'commanderStepper':
        return MaterialPageRoute(builder: (_) => CommanderMyStepperView());
      case 'preparer':
        return MaterialPageRoute(builder: (_) => PreparerCommandesBlocView());
      case 'TestStepper':
        return MaterialPageRoute(builder: (_) => StepperExample());
      case 'administrer':
        return MaterialPageRoute(builder: (_) => AdministrationView());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
              body:
                  Center(child: Text('No route defined for ${settings.name}')));
        });
    }
  }
}
