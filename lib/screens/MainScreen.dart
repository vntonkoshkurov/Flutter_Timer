import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timer/classes/CountDownTimer.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('This is timer'),
      ),
      body: ColumnWidget(),
    );
  }
}

class ColumnWidget extends StatefulWidget {
  const ColumnWidget({
    super.key,
  });

  @override
  State<ColumnWidget> createState() => _ColumnWidgetState();
}

class _ColumnWidgetState extends State<ColumnWidget> {
  late CountDownTimer countDownTimer;

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

  void startTimer() {
    setState(() {
      void updateValues() {
        countDownTimer.secondsToVal();
        countDownTimer.makeTimeString();
      }
      if (countDownTimer.timer != 0) {
        updateValues();
        countDownTimer.timer--;
      } else {
        updateValues();
        countDownTimer.buttonLabelState = countDownTimer.buttonStart;
        countDownTimer.reset();
        stopTimer();
      }
    });
  }

  void stopTimer() {
    countDownTimer.countdownTimer!.cancel();
  }

  @override
  void initState() {
    countDownTimer = CountDownTimer();
    //buttonLabelState = buttonStart;
    //timer = valToSeconds(h: h, m: m, s: s);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            countDownTimer.timeString,
            style: const TextStyle(
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Hours
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Hours'),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 60,
                    padding: EdgeInsets.only(
                      left: 5,
                      right: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black26, width: 2),
                    ),
                    child: DropdownButton(
                      menuMaxHeight: 300,
                      elevation: 8,
                      value: countDownTimer.menuValHours,
                      items: hoursList,
                      onChanged: (value) {
                        if (!countDownTimer.isStarted) {
                          setState(() {
                            countDownTimer.menuValHours = value;
                            countDownTimer.h = int.parse(value);
                            countDownTimer.makeTimeString();
                            countDownTimer.valToSeconds();
                          });
                        } else {
                          null;
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              //Miutes
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Minutes'),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 60,
                    padding: EdgeInsets.only(
                      left: 5,
                      right: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black26, width: 2),
                    ),
                    child: DropdownButton(
                      menuMaxHeight: 300,
                      elevation: 8,
                      value: countDownTimer.menuValMinutes,
                      items: minuteList,
                      onChanged: (value) {
                        if (!countDownTimer.isStarted) {
                          setState(() {
                            countDownTimer.menuValMinutes = value;
                            countDownTimer.m = int.parse(value);
                            countDownTimer.makeTimeString();
                            countDownTimer.valToSeconds();
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              //Seconds
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Seconds'),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 60,
                    padding: EdgeInsets.only(
                      left: 5,
                      right: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black26, width: 2),
                    ),
                    child: DropdownButton(
                        menuMaxHeight: 300,
                        elevation: 8,
                        value: countDownTimer.menuValSeconds,
                        items: secondList,
                        onChanged: (value) {
                          if (!countDownTimer.isStarted) {
                            setState(() {
                              countDownTimer.menuValSeconds = value;
                              countDownTimer.s = int.parse(value);
                              countDownTimer.makeTimeString();
                              countDownTimer.valToSeconds();
                            });
                          }
                        }),
                  ),
                ],
              ),
              //CommandBotton
              const SizedBox(width: 20)
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: TextButton(
              onPressed: () {
                if (!countDownTimer.isStarted) {
                  countDownTimer.isStarted = true;
                  countDownTimer.buttonLabelState = countDownTimer.buttonStop;
                  countDownTimer.valToSeconds();
                  countDownTimer.countdownTimer =
                      Timer.periodic(Duration(seconds: 1), (_) => startTimer());
                } else {
                  setState(() {
                    countDownTimer.isStarted = false;
                    countDownTimer.buttonLabelState =
                        countDownTimer.buttonStart;
                    stopTimer();
                  });
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.blue,
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              child: Text(countDownTimer.buttonLabelState),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Center(
            child: TextButton(
              onPressed: () {
                if (!countDownTimer.isStarted) {
                  setState(() {
                    stopTimer();
                    countDownTimer.reset();
                  });
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.blue,
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              child: Text(countDownTimer.buttonReset),
            ),
          ),
        ],
      ),
    );
  }
}
