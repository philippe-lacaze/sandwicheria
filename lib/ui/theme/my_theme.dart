import 'package:flutter/material.dart';

// Material colors https://material.io/tools/color/#!/?view.left=0&view.right=0&primary.color=82B1FF&secondary.color=FF80AB
const primaryColor = const Color(0xFF82b1ff);
const primaryColorLight = const Color(0xFFb6e3ff);
const primaryColorDark = const Color(0xFF4d82cb);
const secondaryColor = const Color(0xFFff80ab);
const secondaryColorLight = const Color(0xFFffb2dd);
const secondaryDarkColor = const Color(0xFFc94f7c);
const primaryTextColor = const Color(0xFF000000);
const secondaryTextColor = const Color(0xFF000000);

const Background = Colors.white;
const BackgroundDark = Colors.black54;
const TextColor = Colors.black54;

class MyTheme {
  static final ThemeData defaultLightTheme = _buildTheme();

  static ThemeData _buildTheme() {
    final ThemeData base = ThemeData.light();

    final baseTextTheme = base.textTheme.copyWith(
      title: base.textTheme.title.copyWith(color: TextColor, fontSize: 24.0),
      subtitle:
          base.textTheme.subtitle.copyWith(color: TextColor, fontSize: 14.0),
      body1: base.textTheme.body1.copyWith(color: TextColor, fontSize: 20.0),
      body2: base.textTheme.body2.copyWith(color: TextColor, fontSize: 20.0),
      subhead:
          base.textTheme.subhead.copyWith(color: TextColor, fontSize: 20.0),
      caption:
          base.textTheme.caption.copyWith(color: TextColor, fontSize: 16.0),
    );

    final _theme = base.copyWith(
        accentColor: secondaryColor,
        accentColorBrightness: Brightness.dark,
        primaryColor: primaryColor,
        primaryColorDark: primaryColorDark,
        primaryColorLight: primaryColorLight,
        primaryColorBrightness: Brightness.dark,
        buttonTheme: base.buttonTheme.copyWith(
          buttonColor: primaryColorDark,
          textTheme: ButtonTextTheme.primary,
        ),
        scaffoldBackgroundColor: Background,
        cardColor: Background,
        textSelectionColor: primaryColorLight,
        backgroundColor: Background,
        textTheme: baseTextTheme,
        appBarTheme: AppBarTheme(
            textTheme: baseTextTheme.copyWith(
                title: baseTextTheme.title
                    .copyWith(color: Colors.white, fontSize: 32.0))),
        iconTheme: base.iconTheme.copyWith(color: secondaryColor),
        inputDecorationTheme: InputDecorationTheme(
            labelStyle: base.textTheme.body1.copyWith(
                inherit: true, color: secondaryDarkColor, fontSize: 20.0),
            hintStyle: base.textTheme.body1
                .copyWith(inherit: true, color: TextColor, fontSize: 20.0)),
        snackBarTheme: base.snackBarTheme.copyWith(),
        toggleableActiveColor: secondaryDarkColor,
        bottomSheetTheme: base.bottomSheetTheme.copyWith(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft:  Radius.circular(25.0), topRight:  Radius.circular(25.0)),
                side: BorderSide(
                    style: BorderStyle.solid,
                    width: 1.0,
                    color: Colors.grey))));

    return _theme;
  }
}
