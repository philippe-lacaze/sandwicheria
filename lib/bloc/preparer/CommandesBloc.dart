import 'package:bloc/bloc.dart';
import 'package:sandwicheria/bloc/preparer/commandes_events.dart';

import 'package:sandwicheria/bloc/preparer/commandes_states.dart';
import 'package:sandwicheria/core/models/commande.dart';
import 'package:sandwicheria/core/services/commande_service.dart';
import 'package:sandwicheria/locator.dart';

class CommandesBloc extends Bloc<CommandesEvents,CommandesStates> {

  List<Commande> commandes;

  final CommandeService _service = locator<CommandeService>();

  @override
  CommandesStates get initialState => CommandesStates.CommandesNotLoaded;

  @override
  Stream<CommandesStates> mapEventToState(CommandesEvents event) async* {

    print('CommandesBloc.mapEventToState $event');
    if (event == CommandesEvents.LoadCommandes) {
      yield await _mapLoadCommandesToState();
    }

  }

  Future<CommandesStates> _mapLoadCommandesToState() async {
    try {
      this.commandes = await this._service.fetchAll();
      print('_mapLoadCommandesToState commandes = $commandes');
      return CommandesStates.CommandesLoaded;
    } catch (e) {
      print('_mapLoadCommandesToState error = $e');
      return CommandesStates.CommandesNotLoaded;
    }
  }
}