import 'package:flutter/material.dart';
import 'package:sandwicheria/ui/widgets/gradient_app_bar.dart';

createAppBar(BuildContext context, {String title= "La sandwich&ria"}) =>
    GradientAppBar(
      elevation: 0.1,
      backgroundColorStart: Colors.white,
      backgroundColorEnd: Colors.lightBlue,
      gradiantOffsetStart: FractionalOffset(0.0, 1.0),
      gradiantOffsetEnd: FractionalOffset(0.0, 0.0),
      title: Text(title,
          style: Theme
              .of(context)
              .appBarTheme
              .textTheme
              .title),
      bottom: PreferredSize(
          child: Container(), preferredSize: Size.fromHeight(30.0)),
    );