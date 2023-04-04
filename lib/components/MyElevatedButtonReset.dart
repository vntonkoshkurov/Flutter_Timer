import 'package:flutter/material.dart';
import 'package:timer/classes/CountDownTimer.dart';

class MyElevatedButtonReset extends StatefulWidget {
  CountDownTimer countDownTimer;

  MyElevatedButtonReset({
    super.key,
    required this.countDownTimer,
  });

  @override
  State<MyElevatedButtonReset> createState() => _MyElevatedButtonStateReset();
}

class _MyElevatedButtonStateReset extends State<MyElevatedButtonReset> {
  String? buttonLabelState;
  bool buttonState = true;

  callback({required bool buttonState}) {
    this.buttonState = buttonState;
    setState(() {
    });
  }

  Function? onPressed () {
    if (buttonState) {
      widget.countDownTimer.reset();
      setState(() {
      });
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.countDownTimer.getCallbackElevatedButtonReset(callback: callback);
    buttonLabelState = widget.countDownTimer.buttonReset;
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(buttonLabelState!),
    );
  }
}