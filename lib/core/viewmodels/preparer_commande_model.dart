import 'package:sandwicheria/core/models/commande.dart';
import 'package:sandwicheria/core/services/commande_service.dart';
import 'package:sandwicheria/core/viewmodels/base_model.dart';
import 'package:sandwicheria/locator.dart';

class PreparerCommandeModel extends BaseModel {

  CommandeService _service = locator<CommandeService>();

  Commande commande;

  Future toggleTraitee() async {
      await process(() async {
        commande?.traitee = !commande.traitee;
        await _service.update(commande);
      }
    );
  }

}