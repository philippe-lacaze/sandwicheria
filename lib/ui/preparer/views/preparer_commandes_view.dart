
import 'package:flutter/material.dart';
import 'package:sandwicheria/core/viewmodels/preparer_commandes_model.dart';
import 'package:sandwicheria/ui/base_view.dart';
import 'package:sandwicheria/ui/menu_view.dart';
import 'package:sandwicheria/ui/preparer/views/preparer_commande_view.dart';

class PreparerCommandesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<PreparerCommandesModel>(
      onModelReady: (model) {
        return  model.fetchAllCommandes();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(title: Text("Preparer une commande"),),
          drawer: Drawer(
            child: Menu(),
          ),

          body: ListView.builder(
              itemCount: model.commandes?.length ?? 0,
              itemBuilder: (context, index) {
                return PreparerCommandeView(model.commandes[index]);
              }
          ),
        );
      },
    );
  }
}
