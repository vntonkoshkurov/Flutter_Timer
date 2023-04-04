import 'package:flutter/material.dart';
import 'package:timer/classes/CountDownTimer.dart';

class MyElevatedButtonStart extends StatefulWidget {
  CountDownTimer countDownTimer;

  MyElevatedButtonStart({
    super.key,
    required this.countDownTimer,
  });

  @override
  State<MyElevatedButtonStart> createState() => _MyElevatedButtonStateStart();
}

class _MyElevatedButtonStateStart extends State<MyElevatedButtonStart> {
  String? buttonLabelState;

  buttonStartController() {
    setState(() {
    });
  }

  onPressed () {
    if (!widget.countDownTimer.isStarted) {
      widget.countDownTimer.buttonLabelState =
          widget.countDownTimer.buttonPause;
      widget.countDownTimer.startTimer();
    } else {
      widget.countDownTimer.buttonLabelState =
          widget.countDownTimer.buttonStart;
      widget.countDownTimer.stopTimer();
    }
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.countDownTimer.getCallbackElevatedButton(callback: buttonStartController);
    buttonLabelState = widget.countDownTimer.buttonLabelState;
    return ElevatedButton(
        onPressed: onPressed,
        child: Text(buttonLabelState!),
    );
  }
}