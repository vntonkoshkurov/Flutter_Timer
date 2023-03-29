import 'dart:async';

class CountDownTimer {
  String timeString = '00:00:00';
  String menuValHours = '00';
  String menuValMinutes = '00';
  String menuValSeconds = '00';
  Timer? countdownTimer;
  final String buttonStart = 'Start';
  final String buttonStop = 'Stop';
  final String buttonReset = 'Reset';
  late String buttonLabelState;
  int h = 0;
  int m = 0;
  int s = 0;
  int timer = 0;
  bool isStarted = false;

  CountDownTimer(){
    buttonLabelState = buttonStart;
  }

  void makeTimeString () {
    timeString = '${h < 10 ? '0$h' : '$h'}:${m < 10 ? '0$m' : '$m'}:${s < 10 ? '0$s' : '$s'}';
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
  }

}