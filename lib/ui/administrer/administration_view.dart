import 'package:flutter/material.dart';
import 'package:sandwicheria/ui/menu_view.dart';
import 'package:sandwicheria/ui/widgets/the_app_bar.dart';


class AdministrationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeData.dark();
    return Scaffold(
      appBar: createAppBar(context),
      drawer: Drawer(
        child: Menu(),
      ),
//      bottomNavigationBar: Center(
//        child: Text(
//          "Flutter Rocks !",
//          style: _theme.textTheme.subtitle,
//        ),
//      ),
      body: Container(
        color: Colors.black,
        child: ListView(children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8),
                  ),
                  Icon(
                    Icons.build,
                    size: 32.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                  ),
                  Text(
                    "Flutter Rocks !",
                    style: _theme.textTheme.title,
                  ),
                ],
              ),
            ),
          ),
          //Text("form values=${model.getFormValues()}"),

          Divider(),
          LogoWidget(),
        ]),
      ),
    );
  }
}

class LogoWidget extends StatefulWidget {
  _LogoWidgetState createState() => _LogoWidgetState();
}

class _LogoWidgetState extends State<LogoWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              //controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              controller.forward();
            }
          })
          ..addStatusListener((state) => print('$state'));

    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
//  animation = Tween<double>(begin: 5, end: 300).animate(controller);
//      ..addListener(() {
//        setState(() {});
//      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);

//  {
//    return Center(
//      child: Container(
//        margin: EdgeInsets.symmetric(vertical: 10),
//        height: animation.value,
//        width: animation.value,
//        child: FlutterLogo(),
//      ),
//    );
//  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimatedLogo extends AnimatedWidget {
  // Make the Tweens static because they don't change.
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 100, end: 400);

  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: FlutterLogo(),
        ),
      ),
    );
  }
}
