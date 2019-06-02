import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text('Menu', style: Theme.of(context).textTheme.title),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        ListTile(
          title: Text(
            'Commander un menu',
            style: Theme.of(context).textTheme.subhead,
          ),
          leading: Icon(Icons.fastfood),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
            Navigator.pushNamed(context, 'commander');
          },
        ),
        ListTile(
          title: Text('Préparer les commandes',
              style: Theme.of(context).textTheme.subhead),
          leading: Icon(Icons.hot_tub),
          onTap: () {
            // Update the state of the app
            Navigator.pop(context);
            Navigator.pushNamed(context, 'preparer');
          },
        ),
      ],
    );
  }
}
