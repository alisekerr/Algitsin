import 'package:algitsin/core/extensions/size_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatelessWidget {
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Color? backcolor;
  final Widget progressIndicator;
  final Offset? offset;
  final bool dismissible;
  final Widget? child;

  const LoadingPage({
    Key? key,
    required this.inAsyncCall,
    this.opacity = 0.7,
    this.color = Colors.white,
    this.backcolor,
    this.progressIndicator = const CircularProgressIndicator(),
    this.offset,
    this.dismissible = false,
    required this.child,
  })  : assert(child != null),
        assert(inAsyncCall != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child!);
    if (inAsyncCall) {
      Widget layOutProgressIndicator;
      if (offset == null) {
        layOutProgressIndicator = Center(
            child: SizedBox(
                height: 60.0.h,
                width: 60.0.w,
                child: Align(
                    alignment: Alignment.center,
                    child: SpinKitWave(
                      color: Theme.of(context).primaryColor,
                      size: 30.0.spByWidth,
                    ))));
      } else {
        layOutProgressIndicator = Positioned(
          child: progressIndicator,
          left: offset!.dx,
          top: offset!.dy,
        );
      }
      final modal = [
        Opacity(
          child: ModalBarrier(dismissible: dismissible, color: Colors.white),
          opacity: opacity,
        ),
        layOutProgressIndicator
      ];
      widgetList += modal;
    }
    return Stack(
      children: widgetList,
    );
  }
}
