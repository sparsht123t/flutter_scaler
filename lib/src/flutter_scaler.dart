import 'package:flutter/material.dart';

class ScalePickerController extends ValueNotifier<num> {
  /// Creates a controller for scale widget.
  ScalePickerController({num value = 100.0}) : super(value);

  num get value => super.value;
  set value(num newValue) {
    super.value = newValue;
  }
}

///A typedef can be used to specify a function signature that we want specific functions to match.
/// A function signature is defined by a function’s parameters (including their types).
/// The return type is not a part of the function signature.
typedef ValueChangedCallback = void Function(num value);

class ScalePicker extends StatefulWidget {
  ScalePicker(
      {required this.onValueChange,
      required this.width,
      required this.height,
      this.isInvertedScale = false,
      this.backgroundColor = Colors.white,
      this.smallTickColor = Colors.black,
      required this.scalePickerController,
      this.bigTickColor = Colors.green,
      this.isAxisVertical = false,
      this.marker,
      this.shouldTextBeAlignedHorizontallyOnVerticalScroll = false,
      this.animationDuration = const Duration(milliseconds: 500),
      this.textStyle = const TextStyle(fontSize: 14.0),
      this.styleOfScrollValueMatched =
          const TextStyle(fontSize: 22.0, color: Colors.orangeAccent),
      this.initialValue = 0,
      this.markerColor = Colors.yellow})
      : assert(isAxisVertical ? width >= 80 : height >= 80);
  final ValueChangedCallback onValueChange;
  double width;
  double height;
  final Color backgroundColor;
  final Duration animationDuration;
  final Color markerColor;
  final Color smallTickColor;
  final Color bigTickColor;
  final bool isInvertedScale;
  final TextStyle? textStyle;
  final TextStyle? styleOfScrollValueMatched;
  final double initialValue;
  final Widget? marker;
  final bool isAxisVertical;
  final bool shouldTextBeAlignedHorizontallyOnVerticalScroll;

  ScalePickerController scalePickerController;

  @override
  State<ScalePicker> createState() => _ScalePickerState();
}

class _ScalePickerState extends State<ScalePicker> {
  ScrollController scrollController = ScrollController();
  double currentCursorPositionValue = 0;
  Widget defaultMarker({bool isVertical = false}) {
    return !isVertical
        ? SizedBox(
            height: 34,
            child: Stack(
              alignment: widget.isInvertedScale
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              children: <Widget>[
                Container(
                  width: 3.4,
                  height: 34,
                  margin: const EdgeInsets.only(left: 6.0),
                  color: widget.markerColor,
                ),
              ],
            ),
          )
        : SizedBox(
            // width: 34,
            child: Stack(
              alignment: widget.isInvertedScale
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              children: <Widget>[
                Container(
                  width: 34,
                  height: 3.4,
                  margin: const EdgeInsets.only(left: 6.0),
                  color: widget.markerColor,
                ),
              ],
            ),
          );
  }

  @override
  void initState() {
    scrollController = ScrollController();
    widget.scalePickerController.value = widget.initialValue;
    if (widget.isAxisVertical && widget.width <= 80) {
      widget.width = 80;
    }
    if (!widget.isAxisVertical && widget.height <= 80) {
      widget.height = 80;
    }
    /// Jump to specific value initially
    Future.delayed(widget.animationDuration, () {
      scrollController.animateTo(
        widget.isAxisVertical
            ? widget.initialValue * 32
            : widget.initialValue * 10,
        duration: widget.animationDuration,
        curve: Curves.easeOut,
      );
    });
    currentCursorPositionValue = widget.initialValue;
    super.initState();
  }
/// Change cursor position value for horizontal scrolling
  void changePositionForHorizontalScroll(double cursorPosition) {
    setState(() {
      currentCursorPositionValue = cursorPosition;
      widget.scalePickerController.value = cursorPosition;
    });
    widget.onValueChange(cursorPosition);
  }
/// Change cursor position value for vertical scrolling
  void changePositionForVerticalScroll(double cursorPosition) {
    setState(() {
      currentCursorPositionValue = cursorPosition;
      widget.scalePickerController.value = cursorPosition;
    });
    widget.onValueChange(cursorPosition);
  }
/// Horizontal List View of tick item builder
  horizontalListView() {
    return ListView.builder(
        shrinkWrap: true,
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: index == 0
                ? EdgeInsets.only(
                    left: widget.width / 2,
                  )
                : EdgeInsets.zero,
            child: Stack(
              overflow: Overflow.visible,
              children: [
                Positioned(
                  bottom: widget.isInvertedScale ? 0 : 40,
                  top: widget.isInvertedScale ? 40 : 0,
                  width: 50,
                  left: -25,
                  child: index % 10 == 0
                      ? Container(
                          alignment: Alignment.center,
                          child: Text(
                            (index).toString(),
                            style: currentCursorPositionValue == index
                                ? widget.styleOfScrollValueMatched
                                : widget.textStyle,
                          ),
                        )
                      : Container(),
                ),

                /// ----------------------- Pointers
                Align(
                  alignment: widget.isInvertedScale
                      ? Alignment.topCenter
                      : Alignment.bottomCenter,
                  child: SizedBox(
                    width: 10,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Container(
                          width: index % 10 == 0 ? 2 : 1,
                          height: index % 10 == 0 ? 32 : 20,
                          color: index % 10 == 0
                              ? widget.bigTickColor
                              : widget.smallTickColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
/// Marker of horizontal scroll
  markerForHorizontalScroll() {
    return Positioned(
      top: widget.isInvertedScale ? 0.1 : widget.height - 34,
      left: widget.width / 2 - 8,
      child: widget.marker ?? defaultMarker(),
    );
  }
/// Marker of vertical scroll
  markerForVerticalScroll() {
    return Positioned(
      top: widget.height / 2 + 14,
      left: widget.isInvertedScale ? 0 : -6,
      right: widget.isInvertedScale ? 0 : 0,
      child: widget.marker ?? defaultMarker(isVertical: true),
    );
  }
/// Vertical List View of tick item builder
  verticalListView() {
    return ListView.builder(
        shrinkWrap: true,
        controller: scrollController,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: index == 0
                ? EdgeInsets.only(
                    top: widget.height / 2,
                  )
                : EdgeInsets.zero,
            child: Stack(
              overflow: Overflow.visible,
              children: [
                Positioned(
                  left: widget.isInvertedScale ? 0 : 40,
                  bottom: 0,
                  width: 50,
                  top: widget.shouldTextBeAlignedHorizontallyOnVerticalScroll
                      ? 2
                      : 7,
                  child: index % 10 == 0
                      ? RotationTransition(
                          turns: widget.isInvertedScale
                              ? AlwaysStoppedAnimation(widget
                                      .shouldTextBeAlignedHorizontallyOnVerticalScroll
                                  ? 360 / 360
                                  : 270 / 360)
                              : AlwaysStoppedAnimation(widget
                                      .shouldTextBeAlignedHorizontallyOnVerticalScroll
                                  ? 360 / 360
                                  : 90 / 360),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              (index).toString(),
                              style: currentCursorPositionValue == index
                                  ? widget.styleOfScrollValueMatched
                                  : widget.textStyle,
                            ),
                          ),
                        )
                      : Container(),
                ),

                /// ----------------------- Pointers
                Align(
                  alignment: widget.isInvertedScale
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: SizedBox(
                    height: 32,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Container(
                          width: index % 10 == 0 ? 32 : 20,
                          height: index % 10 == 0 ? 2 : 1,
                          color: index % 10 == 0
                              ? widget.bigTickColor
                              : widget.smallTickColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: widget.backgroundColor,
      child: Stack(children: <Widget>[
        Listener(
          child: NotificationListener(
            onNotification: (notificationType) {
              if (notificationType is ScrollEndNotification) {
                widget.isAxisVertical
                    ? changePositionForVerticalScroll(
                        (notificationType.metrics.pixels / 32).roundToDouble())
                    : changePositionForHorizontalScroll(
                        (notificationType.metrics.pixels / 10).roundToDouble());
              }
              return true;
            },
            child: widget.isAxisVertical
                ? verticalListView()
                : horizontalListView(),
          ),
        ),

        ///------------------------ Marker
        widget.isAxisVertical
            ? markerForVerticalScroll()
            : markerForHorizontalScroll(),
      ]),
    );
  }
}
