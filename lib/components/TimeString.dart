import 'package:flutter/material.dart';
import 'package:timer/classes/CountDownTimer.dart';

class TimeString extends StatefulWidget {

  late CountDownTimer countDownTimer;

  TimeString({
    super.key,
    required this.countDownTimer,
  });

  @override
  State<TimeString> createState() => _TimeStringState();

}

class _TimeStringState extends State<TimeString> {

  String timeString = '00:00:00';

  timerController (String newTimeString) {
    setState(() {
      timeString = newTimeString;
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.countDownTimer.getCallbackTimeString(callback: timerController);
    return Text(
      timeString,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}