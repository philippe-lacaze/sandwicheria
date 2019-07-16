import 'package:sandwicheria/bloc/shared/abstract_state.dart';
import 'package:sandwicheria/core/models/commande.dart';

abstract class CommandesStates extends AbstractState {

}

class CommandesLoading extends CommandesStates {
  @override
  String toString() => 'CommandesLoading';
}

class CommandesLoaded extends CommandesStates {
  final List<Commande> commandes;


  CommandesLoaded([this.commandes = const []]) ;

  @override
  String toString() => 'CommandesLoaded';
}

class CommandesNotLoaded extends CommandesStates {
  @override
  String toString() => 'CommandesNotLoaded';
}