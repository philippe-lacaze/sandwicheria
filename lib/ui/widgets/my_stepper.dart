// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart'
    show
        Brightness,
        ButtonTextTheme,
        Colors,
        FlatButton,
        Icons,
        InkResponse,
        InkWell,
        Material,
        MaterialLocalizations,
        TextTheme,
        Theme,
        ThemeData,
        debugCheckHasMaterial,
        debugCheckHasMaterialLocalizations,
        kThemeAnimationDuration;

// TODO(dragostis): Missing functionality:
//   * mobile horizontal mode with adding/removing MySteps
//   * alternative labeling
//   * MyStepper feedback in the case of high-latency interactions

/// The state of a [Step] which is used to control the style of the circle and
/// text.
///
/// See also:
///
///  * [Step]
enum MyStepState {
  /// A MyStep that displays its index in its circle.
  indexed,

  /// A MyStep that displays a pencil icon in its circle.
  editing,

  /// A MyStep that displays a tick icon in its circle.
  complete,

  /// A MyStep that is disabled and does not to react to taps.
  disabled,

  /// A MyStep that is currently having an error. e.g. the user has submitted wrong
  /// input.
  error,
}

/// Defines the [Stepper]'s main axis.
enum MyStepperType {
  /// A vertical layout of the MySteps with their content in-between the titles.
  vertical,

  /// A horizontal layout of the MySteps with their content below the titles.
  horizontal,
}

const TextStyle _kStepStyle = TextStyle(
  fontSize: 12.0,
  color: Colors.white,
);
const Color _kErrorLight = Colors.red;
final Color _kErrorDark = Colors.red.shade400;
const Color _kCircleActiveLight = Colors.white;
const Color _kCircleActiveDark = Colors.black87;
const Color _kDisabledLight = Colors.black38;
const Color _kDisabledDark = Colors.white30;
const double _kStepSize = 24.0;
const double _kTriangleHeight =
    _kStepSize * 0.866025; // Triangle height. sqrt(3.0) / 2.0

/// A material MyStep used in [Stepper]. The MyStep can have a title and subtitle,
/// an icon within its circle, some content and a state that governs its
/// styling.
///
/// See also:
///
///  * [Stepper]
///  * <https://material.io/archive/guidelines/components/steppers.html>
class MyStep {
  /// Creates a MyStep for a [Stepper].
  ///
  /// The [title], [content], and [state] arguments must not be null.
  MyStep(
      {@required this.title,
      this.subtitle,
      @required this.content,
      this.state = MyStepState.indexed,
      this.isActive = false,
      this.condition,
      this.labelId})
      : assert(title != null),
        assert(content != null),
        assert(state != null);

  /// The title of the MyStep that typically describes it.
  final Widget title;

  /// The subtitle of the MyStep that appears below the title and has a smaller
  /// font size. It typically gives more details that complement the title.
  ///
  /// If null, the subtitle is not shown.
  final Widget subtitle;

  /// The content of the MyStep that appears below the [title] and [subtitle].
  ///
  /// Below the content, every MyStep has a 'continue' and 'cancel' button.
  final Widget content;

  /// The state of the MyStep which determines the styling of its components
  /// and whether MySteps are interactive.
  final MyStepState state;

  /// Whether or not the MyStep is active. The flag only influences styling.
  final bool isActive;

  final Function condition;

  String labelId;

  @override
  String toString() {
    return 'MyStep{state: $state, isActive: $isActive, labelId: $labelId}';
  }


}

/// A material MyStepper widget that displays progress through a sequence of
/// MySteps. MySteppers are particularly useful in the case of forms where one MyStep
/// requires the completion of another one, or where multiple MySteps need to be
/// completed in order to submit the whole form.
///
/// The widget is a flexible wrapper. A parent class should pass [currentStep]
/// to this widget based on some logic triggered by the three callbacks that it
/// provides.
///
/// See also:
///
///  * [Step]
///  * <https://material.io/archive/guidelines/components/steppers.html>
class MyStepper extends StatefulWidget {
  /// Creates a MyStepper from a list of MySteps.
  ///
  /// This widget is not meant to be rebuilt with a different list of MySteps
  /// unless a key is provided in order to distinguish the old MyStepper from the
  /// new one.
  ///
  /// The [steps], [type], and [currentStep] arguments must not be null.
  MyStepper({
    Key key,
    @required this.mySteps,
    this.physics,
    this.type = MyStepperType.vertical,
    this.currentStep = 0,
    this.onStepTapped,
    this.onStepContinue,
    this.onStepCancel,
    this.controlsBuilder,
    this.stepStyle = _kStepStyle,
  })  : assert(mySteps != null),
        assert(type != null),
        assert(currentStep != null),
        assert(0 <= currentStep && currentStep < mySteps.length),
        super(key: key);

  final TextStyle stepStyle;

  /// The MySteps of the MyStepper whose titles, subtitles, icons always get shown.
  ///
  /// The length of [steps] must not change.
  final List<MyStep> mySteps;

  /// How the MyStepper's scroll view should respond to user input.
  ///
  /// For example, determines how the scroll view continues to
  /// animate after the user stops dragging the scroll view.
  ///
  /// If the MyStepper is contained within another scrollable it
  /// can be helpful to set this property to [ClampingScrollPhysics].
  final ScrollPhysics physics;

  /// The type of MyStepper that determines the layout. In the case of
  /// [StepperType.horizontal], the content of the current MyStep is displayed
  /// underneath as opposed to the [StepperType.vertical] case where it is
  /// displayed in-between.
  final MyStepperType type;

  /// The index into [steps] of the current MyStep whose content is displayed.
  final int currentStep;

  /// The callback called when a MyStep is tapped, with its index passed as
  /// an argument.
  final ValueChanged<int> onStepTapped;

  /// The callback called when the 'continue' button is tapped.
  ///
  /// If null, the 'continue' button will be disabled.
  final VoidCallback onStepContinue;

  /// The callback called when the 'cancel' button is tapped.
  ///
  /// If null, the 'cancel' button will be disabled.
  final VoidCallback onStepCancel;

  /// The callback for creating custom controls.
  ///
  /// If null, the default controls from the current theme will be used.
  ///
  /// This callback which takes in a context and two functions,[onStepContinue]
  /// and [onStepCancel]. These can be used to control the MyStepper.
  ///
  /// {@tool snippet --template=stateless_widget_scaffold}
  /// Creates a MyStepper control with custom buttons.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///   return MyStepper(
  ///     controlsBuilder:
  ///       (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
  ///          return Row(
  ///            children: <Widget>[
  ///              FlatButton(
  ///                onPressed: onStepContinue,
  ///                child: const Text('CONTINUE'),
  ///              ),
  ///              FlatButton(
  ///                onPressed: onStepCancel,
  ///                child: const Text('CANCEL'),
  ///              ),
  ///            ],
  ///          );
  ///       },
  ///     MySteps: const <Step>[
  ///       MyStep(
  ///         title: Text('A'),
  ///         content: SizedBox(
  ///           width: 100.0,
  ///           height: 100.0,
  ///         ),
  ///       ),
  ///       MyStep(
  ///         title: Text('B'),
  ///         content: SizedBox(
  ///           width: 100.0,
  ///           height: 100.0,
  ///         ),
  ///       ),
  ///     ],
  ///   );
  /// }
  /// ```
  /// {@end-tool}
  final ControlsWidgetBuilder controlsBuilder;

  MyStepperState currentState;

  @override
  MyStepperState createState() {
    currentState = MyStepperState();
    return currentState;
  }
}

class MyStepperState extends State<MyStepper> with TickerProviderStateMixin {
  List<GlobalKey> _keys;
  final Map<int, MyStepState> _oldStates = <int, MyStepState>{};

  int length() => widget.mySteps?.length ?? 0;

  @override
  void initState() {
    super.initState();
    _keys = List<GlobalKey>.generate(
      widget.mySteps.length,
      (int i) => GlobalKey(),
    );

    for (int i = 0; i < widget.mySteps.length; i += 1)
      _oldStates[i] = widget.mySteps[i].state;
  }

  @override
  void didUpdateWidget(MyStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(widget.mySteps.length == oldWidget.mySteps.length);

    for (int i = 0; i < oldWidget.mySteps.length; i += 1)
      _oldStates[i] = oldWidget.mySteps[i].state;
  }

  bool _isFirst(int index) {
    return index == 0;
  }

  bool _isLast(int index) {
    return widget.mySteps.length - 1 == index;
  }

  bool _isCurrent(int index) {
    return widget.currentStep == index;
  }

  bool _isDark() {
    return Theme.of(context).brightness == Brightness.dark;
  }

  Widget _buildLine(bool visible) {
    return Container(
      width: visible ? 1.0 : 0.0,
      height: 16.0,
      color: Colors.grey.shade400,
    );
  }

  Widget _buildCircleChild(int index, bool oldState) {
    final MyStepState state =
        oldState ? _oldStates[index] : widget.mySteps[index].state;
    final bool isDarkActive = _isDark() && widget.mySteps[index].isActive;
    assert(state != null);
    switch (state) {
      case MyStepState.indexed:
      case MyStepState.disabled:
        return Text(
          '${widget.mySteps[index].labelId ?? index + 1}',
          style: isDarkActive
              ? _kStepStyle.copyWith(color: Colors.black87)
              : _kStepStyle,
        );
      case MyStepState.editing:
        return Icon(
          Icons.edit,
          color: isDarkActive ? _kCircleActiveDark : _kCircleActiveLight,
          size: 18.0,
        );
      case MyStepState.complete:
        return Icon(
          Icons.check,
          color: isDarkActive ? _kCircleActiveDark : _kCircleActiveLight,
          size: 18.0,
        );
      case MyStepState.error:
        return const Text('!', style: _kStepStyle);
    }
    return null;
  }

  Color _circleColor(int index) {
    final ThemeData themeData = Theme.of(context);
    if (!_isDark()) {
      return widget.mySteps[index].isActive
          ? themeData.primaryColor
          : Colors.black38;
    } else {
      return widget.mySteps[index].isActive
          ? themeData.accentColor
          : themeData.backgroundColor;
    }
  }

  Widget _buildCircle(int index, bool oldState) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1.0),
      width: _kStepSize,
      height: _kStepSize,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: kThemeAnimationDuration,
        decoration: BoxDecoration(
          color: _circleColor(index),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: _buildCircleChild(index,
              oldState && widget.mySteps[index].state == MyStepState.error),
        ),
      ),
    );
  }

  Widget _buildTriangle(int index, bool oldState) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: _kStepSize,
      height: _kStepSize,
      child: Center(
        child: SizedBox(
          width: _kStepSize,
          height: _kTriangleHeight,
          // Height of 24dp-long-sided equilateral triangle.
          child: CustomPaint(
            painter: _TrianglePainter(
              color: _isDark() ? _kErrorDark : _kErrorLight,
            ),
            child: Align(
              alignment: const Alignment(0.0, 0.8),
              // 0.8 looks better than the geometrical 0.33.
              child: _buildCircleChild(index,
                  oldState && widget.mySteps[index].state != MyStepState.error),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(int index) {
    if (widget.mySteps[index].state != _oldStates[index]) {
      return AnimatedCrossFade(
        firstChild: _buildCircle(index, true),
        secondChild: _buildTriangle(index, true),
        firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
        secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
        sizeCurve: Curves.fastOutSlowIn,
        crossFadeState: widget.mySteps[index].state == MyStepState.error
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: kThemeAnimationDuration,
      );
    } else {
      if (widget.mySteps[index].state != MyStepState.error)
        return _buildCircle(index, false);
      else
        return _buildTriangle(index, false);
    }
  }

  Widget _buildVerticalControls() {
    if (widget.controlsBuilder != null)
      return widget.controlsBuilder(context,
          onStepContinue: widget.onStepContinue,
          onStepCancel: widget.onStepCancel);

    Color cancelColor;

    switch (Theme.of(context).brightness) {
      case Brightness.light:
        cancelColor = Colors.black54;
        break;
      case Brightness.dark:
        cancelColor = Colors.white70;
        break;
    }

    assert(cancelColor != null);

    final ThemeData themeData = Theme.of(context);
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(height: 48.0),
        child: Row(
          children: <Widget>[
            FlatButton(
              onPressed: widget.onStepContinue,
              color: _isDark()
                  ? themeData.backgroundColor
                  : themeData.primaryColor,
              textColor: Colors.white,
              textTheme: ButtonTextTheme.normal,
              child: Text(localizations.continueButtonLabel),
            ),
            Container(
              margin: const EdgeInsetsDirectional.only(start: 8.0),
              child: FlatButton(
                onPressed: widget.onStepCancel,
                textColor: cancelColor,
                textTheme: ButtonTextTheme.normal,
                child: Text(localizations.cancelButtonLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _titleStyle(int index) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    assert(widget.mySteps[index].state != null);
    switch (widget.mySteps[index].state) {
      case MyStepState.indexed:
      case MyStepState.editing:
      case MyStepState.complete:
        return textTheme.body2;
      case MyStepState.disabled:
        return textTheme.body2
            .copyWith(color: _isDark() ? _kDisabledDark : _kDisabledLight);
      case MyStepState.error:
        return textTheme.body2
            .copyWith(color: _isDark() ? _kErrorDark : _kErrorLight);
    }
    return null;
  }

  TextStyle _subtitleStyle(int index) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    assert(widget.mySteps[index].state != null);
    switch (widget.mySteps[index].state) {
      case MyStepState.indexed:
      case MyStepState.editing:
      case MyStepState.complete:
        return textTheme.caption;
      case MyStepState.disabled:
        return textTheme.caption
            .copyWith(color: _isDark() ? _kDisabledDark : _kDisabledLight);
      case MyStepState.error:
        return textTheme.caption
            .copyWith(color: _isDark() ? _kErrorDark : _kErrorLight);
    }
    return null;
  }

  Widget _buildHeaderText(int index) {
    final List<Widget> children = <Widget>[
      AnimatedDefaultTextStyle(
        style: _titleStyle(index),
        duration: kThemeAnimationDuration,
        curve: Curves.fastOutSlowIn,
        child: widget.mySteps[index].title,
      ),
    ];

    if (widget.mySteps[index].subtitle != null)
      children.add(
        Container(
          margin: const EdgeInsets.only(top: 2.0),
          child: AnimatedDefaultTextStyle(
            style: _subtitleStyle(index),
            duration: kThemeAnimationDuration,
            curve: Curves.fastOutSlowIn,
            child: widget.mySteps[index].subtitle,
          ),
        ),
      );

    return Container(
        width: MediaQuery.of(context).size.width * 0.75,
        margin: EdgeInsets.only(
            top: widget.mySteps[index].subtitle != null ? 16.0 : 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ));
  }

  Widget _buildVerticalHeader(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              // Line parts are always added in order for the ink splash to
              // flood the tips of the connector lines.
              _buildLine(!_isFirst(index)),
              _buildIcon(index),
              _buildLine(!_isLast(index)),
            ],
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(start: 12.0),
            child: _buildHeaderText(index),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalBody(int index) {
    return Stack(
      children: <Widget>[
        PositionedDirectional(
          start: 24.0,
          top: 0.0,
          bottom: 0.0,
          child: SizedBox(
            width: 24.0,
            child: Center(
              child: SizedBox(
                width: _isLast(index) ? 0.0 : 1.0,
                child: Container(
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: Opacity(child: Container(height: 0.0),opacity: 0.0,),
          secondChild: Opacity(
            opacity: 1.0,
            child: Container(
              margin: const EdgeInsetsDirectional.only(
                start: 60.0,
                end: 24.0,
                bottom: 24.0,
              ),
              child: Column(
                children: <Widget>[
                  widget.mySteps[index].content,
                  _buildVerticalControls(),
                ],
              ),
            ),
          ),
          firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
          secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
          sizeCurve: Curves.fastOutSlowIn,
          crossFadeState: _isCurrent(index)
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: kThemeAnimationDuration * 4,
        ),
      ],
    );
  }

  Widget _buildVertical() {
    final List<Widget> children = <Widget>[];

    int labelIndex = 0;

    for (int i = 0; i < widget.mySteps.length; i += 1) {
      if (widget.mySteps[i].condition != null &&
          !widget.mySteps[i].condition()) {
        children.add(Container(key: _keys[i]));
      } else {
        labelIndex++;
        if (widget.mySteps[i].labelId == null) {
          widget.mySteps[i].labelId = '$labelIndex';
        }
        children.add(Column(
          key: _keys[i],
          children: <Widget>[
            InkWell(
              onTap: widget.mySteps[i].state != MyStepState.disabled
                  ? () {
                      // In the vertical case we need to scroll to the newly tapped
                      // MyStep.
                      Scrollable.ensureVisible(
                        _keys[i].currentContext,
                        curve: Curves.fastOutSlowIn,
                        duration: kThemeAnimationDuration * 4,
                      );

                      if (widget.onStepTapped != null) widget.onStepTapped(i);
                    }
                  : null,
              child: _buildVerticalHeader(i),
            ),
            _buildVerticalBody(i),
          ],
        ));
      }
    }

    return ListView(
      shrinkWrap: true,
      physics: widget.physics,
      children: children,
    );
  }

  Widget _buildHorizontal() {
    final List<Widget> children = <Widget>[];

    for (int i = 0; i < widget.mySteps.length; i += 1) {
      children.add(
        InkResponse(
          onTap: widget.mySteps[i].state != MyStepState.disabled
              ? () {
                  if (widget.onStepTapped != null) widget.onStepTapped(i);
                }
              : null,
          child: Row(
            children: <Widget>[
              Container(
                height: 72.0,
                child: Center(
                  child: _buildIcon(i),
                ),
              ),
              Container(
                  margin: const EdgeInsetsDirectional.only(start: 12.0),
                  child: _buildHeaderText(i)),
            ],
          ),
        ),
      );

      if (!_isLast(i)) {
        children.add(
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              height: 1.0,
              color: Colors.grey.shade400,
            ),
          ),
        );
      }
    }

    return Column(
      children: <Widget>[
        Material(
          elevation: 2.0,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: children,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(24.0),
            children: <Widget>[
              AnimatedSize(
                curve: Curves.fastOutSlowIn,
                duration: kThemeAnimationDuration,
                vsync: this,
                child: widget.mySteps[widget.currentStep].content,
              ),
              _buildVerticalControls(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    assert(() {
      if (context.ancestorWidgetOfExactType(MyStepper) != null)
        throw FlutterError(
            'Steppers must not be nested. The material specification advises '
            'that one should avoid embedding MySteppers within MySteppers. '
            'https://material.io/archive/guidelines/components/steppers.html#steppers-usage\n');
      return true;
    }());
    assert(widget.type != null);
    switch (widget.type) {
      case MyStepperType.vertical:
        return _buildVertical();
      case MyStepperType.horizontal:
        return _buildHorizontal();
    }
    return null;
  }
}

// Paints a triangle whose base is the bottom of the bounding rectangle and its
// top vertex the middle of its top.
class _TrianglePainter extends CustomPainter {
  _TrianglePainter({
    this.color,
  });

  final Color color;

  @override
  bool hitTest(Offset point) => true; // Hitting the rectangle is fine enough.

  @override
  bool shouldRepaint(_TrianglePainter oldPainter) {
    return oldPainter.color != color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double base = size.width;
    final double halfBase = size.width / 2.0;
    final double height = size.height;
    final List<Offset> points = <Offset>[
      Offset(0.0, height),
      Offset(base, height),
      Offset(halfBase, 0.0),
    ];

    canvas.drawPath(
      Path()..addPolygon(points, true),
      Paint()..color = color,
    );
  }
}
