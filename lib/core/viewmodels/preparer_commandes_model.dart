import 'package:sandwicheria/core/models/commande.dart';
import 'package:sandwicheria/core/services/commande_service.dart';
import 'package:sandwicheria/core/viewmodels/base_model.dart';
import 'package:sandwicheria/locator.dart';

class PreparerCommandesModel extends BaseModel {

  CommandeService _service = locator<CommandeService>();

  List<Commande> commandes;

  Future fetchAllCommandes() async {
    await process(() async {
      commandes = await _service.fetchAll();
      print('commandes = $commandes');
    });
  }

}