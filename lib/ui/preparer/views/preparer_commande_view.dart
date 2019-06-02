import 'package:flutter/material.dart';
import 'package:sandwicheria/core/models/commande.dart';
import 'package:sandwicheria/core/viewmodels/preparer_commande_model.dart';
import 'package:sandwicheria/ui/preparer/views/base_view.dart';

class PreparerCommandeView extends StatelessWidget {
  final Commande _commande;

  PreparerCommandeView(this._commande) {
    print('PreparerCommandeView {commande}');
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text('Pour ${_commande.client}, ${_commande.menu}'),
        subtitle: Text(_commande.articles()),
        trailing: BaseView<PreparerCommandeModel>(
            onModelReady: (model) => model.commande = _commande,
            builder: (context, model, child) {
              final Commande commande = model.commande;
              return IconButton(
                  icon: Icon(commande.traitee
                      ? Icons.check_box
                      : Icons.check_box_outline_blank),
                  onPressed: () {
                    model.toggleTraitee();
                  });
            }));
  }
}
