import 'package:flutter/material.dart';
import 'package:timer/classes/CountDownTimer.dart';

class MyDropDownButton extends StatefulWidget {
  List<DropdownMenuItem<dynamic>>? valueList;
  static const String HOURS = 'h';
  static const String MINUTES = 'm';
  static const String SECONDS = 's';
  CountDownTimer countDownTimer;
  String value = '00';
  String typeOfVal;
  bool buttonState = true;

  MyDropDownButton({
    super.key,
    required List<DropdownMenuItem<dynamic>> this.valueList,
    required this.countDownTimer,
    required this.typeOfVal,
  });

  @override
  State<MyDropDownButton> createState() => _MyDropDownButtonState();
}

class _MyDropDownButtonState extends State<MyDropDownButton> {

  callback({bool reset = false}){
    setState(() {
      if (widget.countDownTimer.isStarted) {
        widget.buttonState = false;
      } else {
        widget.buttonState = true;
      }
      if (reset) {
        widget.value = '00';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.countDownTimer.isStarted) {
      switch (widget.typeOfVal) {
        case 'h':
          widget.countDownTimer.getCallbackDropDownButtonHour(callback: callback);
          break;
        case 'm':
          widget.countDownTimer.getCallbackDropDownButtonMinute(callback: callback);
          break;
        case 's':
          widget.countDownTimer.getCallbackDropDownButtonSecond(callback: callback);
          break;
      }
    }
    return DropdownButton(
        value: widget.value,
        items: widget.valueList,
        menuMaxHeight: 250,
        onChanged:  (value) {
          if (widget.buttonState) {
            setState(() {
              widget.value = value;
              switch (widget.typeOfVal) {
                case 'h':
                  widget.countDownTimer.h = int.parse(value);
                  break;
                case 'm':
                  widget.countDownTimer.m = int.parse(value);
                  break;
                case 's':
                  widget.countDownTimer.s = int.parse(value);
              }
              widget.countDownTimer.makeTimeString();
            });
          } else {
            null;
          }
        });
  }
}
