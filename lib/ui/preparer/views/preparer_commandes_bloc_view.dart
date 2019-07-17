import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandwicheria/bloc/preparer/CommandesBloc.dart';
import 'package:sandwicheria/bloc/preparer/commandes_events.dart';
import 'package:sandwicheria/bloc/preparer/commandes_states.dart';
import 'package:sandwicheria/core/viewmodels/preparer_commandes_model.dart';
import 'package:sandwicheria/ui/menu_view.dart';
import 'package:sandwicheria/ui/preparer/views/preparer_commande_view.dart';
import 'package:sandwicheria/ui/widgets/the_app_bar.dart';

class PreparerCommandesBlocView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CommandesBloc _commandesBloc = CommandesBloc();
    final ThemeData _theme = Theme.of(context);

    _commandesBloc.dispatch(CommandesEvents.LoadCommandes);

    return BlocProvider(
        builder: (BuildContext context) => _commandesBloc,
        child: Scaffold(
            appBar: createAppBar(context),
            drawer: Drawer(
              child: Menu(),
            ),
            body: Stack(
              children: [
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              top: 8.0, bottom: 8.0, right: 8.0),
                        ),
                        Icon(
                          Icons.hot_tub,
                          size: _theme.textTheme.title.fontSize + 8.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                        ),
                        Expanded(
                          child: Text(
                            " Gérez les commandes",
                            style: _theme.textTheme.title,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Validez les commandes",
                    style: _theme.textTheme.subtitle,
                  ),
                  Divider(),
                  BlocBuilder(
                      bloc: _commandesBloc,
                      builder: (BuildContext context, CommandesStates state) {
                        print('PreparerCommandesBlocView state=$state');
                        var loaded =  (state == CommandesStates.CommandesLoaded);
                        print('PreparerCommandesBlocView loaded=$loaded ,commande=${_commandesBloc.commandes} ');
                        return Expanded(
                            child: _inProgress(!loaded, _body2(_commandesBloc))
                        );
                      }),

                ])
              ],
            )));

/*
    return BaseView<PreparerCommandesModel>(
      onModelReady: (model) {
        return model.fetchAllCommandes();
      },
      builder: (context, model, child) {
        return Scaffold(
            appBar: createAppBar(context),
            drawer: Drawer(
              child: Menu(),
            ),
            body: Stack(
              children: [
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top:8.0, bottom: 8.0, right: 8.0),
                        ),
                        Icon(
                          Icons.hot_tub,
                          size: _theme.textTheme.title.fontSize + 8.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                        ),
                        Expanded(
                          child: Text(
                            " Gérez les commandes",
                            style: _theme.textTheme.title,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Validez les commandes",
                    style: _theme.textTheme.subtitle,
                  ),
                  Divider(),
                  _inProgress(
                      model.pendingRequest,
                      Expanded(
                        child: _body(model),
                      )),
                ])
              ],
            ));
      },
    );
*/
  }

  /*
  StatelessWidget _body(PreparerCommandesModel model) {
    return ((model.commandes?.length ?? 0) > 0)
        ? ListView.builder(
        itemCount: model.commandes?.length ?? 0,
        itemBuilder: (context, index) {
          return PreparerCommandeView(model.commandes[index]);
        })
        : Container(
      child: Center(
        child: Text("Aucune commande pour le moment..."),
      ),
    );
  }
  */

  StatelessWidget _body2(CommandesBloc bloc) {

    var notEmpty = ((bloc.commandes?.length ?? 0) > 0);
    print('PreparerCommandesBlocView._body2 notEmpty=$notEmpty');

    return notEmpty
        ? ListView.builder(
        itemCount: bloc.commandes?.length ?? 0,
        itemBuilder: (context, index) {
          print('PreparerCommandesBlocView._body2 itemBuilder=${bloc.commandes[index]} ');
          return PreparerCommandeView(bloc.commandes[index]);
        })
        : Container(
      child: Center(
        child: Text("Aucune commande pour le moment..."),
      ),
    );
  }

}


Widget _inProgress(bool show, Widget child) {
  if (show) {
    print('Inprogress show');
    var modal = new Stack(
      children: [
//        new Opacity(
//          opacity: 0.3,
//          child: const ModalBarrier(dismissible: false, color: Colors.grey),
//        ),

        ConstrainedBox(
          constraints: BoxConstraints.tight(Size(100.0, 400.0)),
          child: Center(child: new CircularProgressIndicator()),
        )
      ],
    );
    return modal;
  } else
    print('Inprogress hide');
  return child;
}
