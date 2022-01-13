import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:algitsin/core/extensions/size_extention.dart';
import 'package:algitsin/feature/service/auth/google_signin_provider.dart';

class BaseButton extends StatefulWidget {
  void Function() function;
  FaIcon icon;
  String text;
  BaseButton({
    Key? key,
    required this.function,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  _BaseButtonState createState() => _BaseButtonState();
}

class _BaseButtonState extends State<BaseButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
                  width: 343.0.w,
                  height: 57.0.h,
                  child: ElevatedButton(
                    onPressed:widget.function,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.icon,
                        SizedBox(width: 10.0.w),
                        Text(
                          widget.text,
                          style: Theme.of(context).textTheme.button!.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                  ),
                );
  }
}