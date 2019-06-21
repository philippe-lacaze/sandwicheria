import 'package:flutter/material.dart';
import 'package:sandwicheria/core/models/commande.dart';
import 'package:sandwicheria/core/viewmodels/preparer_commande_model.dart';
import 'package:sandwicheria/ui/base_view.dart';
import 'package:sandwicheria/ui/theme/my_theme.dart';
import 'package:sandwicheria/ui/util/utils.dart';

class PreparerCommandeView extends StatelessWidget {
  final Commande _commande;

  PreparerCommandeView(this._commande) {}

  @override
  Widget build(BuildContext context) {

    print('>>PreparerCommandeView.build');
    var _theme = Theme.of(context);

    return ListTile(
        isThreeLine: true,
        leading: Image.asset(
          getImageName(_commande),
          width: 32.0,
          height: 32.0,
        ),
        title: Text(
          'Pour ${_commande.client}, menu ${_commande.menu}',
          style: TextStyle(color: secondaryDarkColor),
        ),
        subtitle: Text(
          _commande.articles(),
          style: _theme.textTheme.subtitle,
        ),
        trailing: BaseView<PreparerCommandeModel>(
            onModelReady: (model) => model.commande = _commande,
            builder: (context, model, child) {
              print('>>PreparerCommandeView');
              final Commande commande = model.commande;
              return IconButton(
                  icon: Icon(
                    commande.traitee
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: secondaryDarkColor,
                    size: 32.0,
                  ),
                  onPressed: () {
                    model.toggleTraitee();
                  });
            }));
  }
}


