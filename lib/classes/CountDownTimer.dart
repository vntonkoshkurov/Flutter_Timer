import 'dart:async';

import 'package:flutter/material.dart';

class CountDownTimer {
  String timeString = '00:00:00';
  String menuValHours = '00';
  String menuValMinutes = '00';
  String menuValSeconds = '00';
  Timer? countdownTimer;
  final String buttonStart = 'Start';
  final String buttonPause = "Pause";
  final String buttonStop = 'Stop';
  final String buttonReset = 'Reset';
  late String buttonLabelState;
  int h = 0;
  int m = 0;
  int s = 0;
  int timer = 0;
  bool isStarted = false;
  Function? callbackTimeString;
  Function? callbackElevatedButton;
  Function? callbackDropDownButtonHour;
  Function? callbackDropDownButtonMinute;
  Function? callbackDropDownButtonSecond;
  Function? callbackElevatedButtonReset;

  CountDownTimer(){
    buttonLabelState = buttonStart;
  }

  final List<DropdownMenuItem<dynamic>> hoursList = _intToStringConverter(24)
      .map((value) => DropdownMenuItem(value: value, child: Text(value)))
      .toList();

  final List<DropdownMenuItem<dynamic>> minuteList = _intToStringConverter(60)
      .map((value) => DropdownMenuItem(value: value, child: Text(value)))
      .toList();

  final List<DropdownMenuItem<dynamic>> secondList = _intToStringConverter(60)
      .map((value) => DropdownMenuItem(value: value, child: Text(value)))
      .toList();

  static List<String> _intToStringConverter(int index) {
    List<String> items = [];
    for (int i = 0; i < index; i++) {
      items.add(i < 10 ? '0$i' : '$i');
    }
    return items;
  }

  void makeTimeString () {
    timeString = '${h < 10 ? '0$h' : '$h'}:${m < 10 ? '0$m' : '$m'}:${s < 10 ? '0$s' : '$s'}';
    callbackTimeString!(timeString);
  }

  void valToSeconds () {
    timer = h * 3600 + m * 60 + s;
  }

  void secondsToVal () {
    s = timer % 60;
    h = timer ~/ 60;
    m = h % 60;
    h = h ~/ 60;
  }

  void reset () {
    menuValHours = '00';
    menuValMinutes = '00';
    menuValSeconds = '00';
    h = 0;
    m = 0;
    s = 0;
    makeTimeString();
    isStarted = false;
    callbackDropDownButtonHour!(reset: true);
    callbackDropDownButtonMinute!(reset: true);
    callbackDropDownButtonSecond!(reset: true);
  }

  void getCallbackTimeString({required Function callback}) {
    callbackTimeString = callback;
  }

  void getCallbackElevatedButton({required Function callback}) {
    callbackElevatedButton = callback;
  }

  void getCallbackDropDownButtonHour({required Function callback}) {
    callbackDropDownButtonHour = callback;
  }

  void getCallbackDropDownButtonMinute({required Function callback}) {
    callbackDropDownButtonMinute = callback;
  }

  void getCallbackDropDownButtonSecond({required Function callback}) {
    callbackDropDownButtonSecond = callback;
  }

  void getCallbackElevatedButtonReset({required Function callback}) {
    callbackElevatedButtonReset = callback;
}

  startTimer() {
    isStarted = true;
    callbackDropDownButtonHour!();
    callbackDropDownButtonMinute!();
    callbackDropDownButtonSecond!();
    callbackElevatedButtonReset!(buttonState: false);
    valToSeconds();
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (timer > 0) {
        timer--;
        secondsToVal();
        makeTimeString();
        callbackTimeString!(timeString);
        if (timer == 0) stopTimer();
      } else {
        countdownTimer!.cancel();
        secondsToVal();
        stopTimer();
      }
    });
  }

  stopTimer(){
    isStarted = false;
    if (timer > 0) {
      buttonLabelState = buttonStart;
      countdownTimer!.cancel();
    } else {
      reset();
      buttonLabelState = buttonStart;
      countdownTimer!.cancel();
      callbackElevatedButton!();
    }
    callbackDropDownButtonHour!();
    callbackDropDownButtonMinute!();
    callbackDropDownButtonSecond!();
    callbackElevatedButtonReset!(buttonState: true);
  }
}