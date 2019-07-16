import 'package:sandwicheria/bloc/shared/abstract_event.dart';

abstract class CommandesEvents extends AbstractEvent {

}

class LoadCommandes extends CommandesEvents{

  @override
  String toString() => 'LoadCommandes';
}
