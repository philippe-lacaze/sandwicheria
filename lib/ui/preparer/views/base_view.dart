import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandwicheria/core/viewmodels/base_model.dart';
import 'package:sandwicheria/locator.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {

  final Widget Function(BuildContext context, T value, Widget child) builder;
  final Function(T) onModelReady;

  BaseView({@required this.builder, this.onModelReady});

  @override
  _BaseViewState createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {

  final T model = locator<T>();


  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      builder: (context) => model,
      child: Consumer<T>(builder: widget.builder)
    );
  }
}
