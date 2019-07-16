import 'package:bloc/bloc.dart';
import 'package:sandwicheria/bloc/preparer/commandes_events.dart';
import 'package:sandwicheria/bloc/preparer/commandes_states.dart';
import 'package:sandwicheria/core/services/commande_service.dart';
import 'package:sandwicheria/locator.dart';

class CommandesBloc extends Bloc<CommandesEvents,CommandesStates> {

  final CommandeService _service = locator<CommandeService>();

  @override
  CommandesStates get initialState => CommandesLoading();

  @override
  Stream<CommandesStates> mapEventToState(CommandesEvents event) async* {

    if (event is LoadCommandes) {
      yield* _mapLoadCommandesToState();
    }

  }

  Stream<CommandesStates> _mapLoadCommandesToState() async* {
    try {
      final commandes = await this._service.fetchAll();
      yield CommandesLoaded(
        commandes.toList(),
      );
    } catch (_) {
      yield CommandesNotLoaded();
    }
  }
}