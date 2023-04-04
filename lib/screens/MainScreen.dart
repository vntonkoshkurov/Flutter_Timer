import 'package:flutter/material.dart';
import 'package:timer/classes/CountDownTimer.dart';
import 'package:timer/components/TimeString.dart';

import '../components/MyDropDownButton.dart';
import '../components/MyElevatedButton.dart';
import '../components/MyElevatedButtonReset.dart';

class MainScreen extends StatelessWidget {
  CountDownTimer countDownTimer = CountDownTimer();

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('This is timer'),
      ),
      body: Container(
        color: Colors.green[300],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TimeString(
              countDownTimer: countDownTimer,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
              MyDropDownButton(
                valueList: countDownTimer.hoursList,
                countDownTimer: countDownTimer,
                typeOfVal: MyDropDownButton.HOURS
              ),
              MyDropDownButton(
                valueList: countDownTimer.minuteList,
                countDownTimer: countDownTimer,
                typeOfVal: MyDropDownButton.MINUTES
              ),
              MyDropDownButton(
                valueList: countDownTimer.secondList,
                countDownTimer: countDownTimer,
                typeOfVal: MyDropDownButton.SECONDS
              ),
            ]),
            MyElevatedButtonStart(countDownTimer: countDownTimer),
            MyElevatedButtonReset(countDownTimer: countDownTimer),
          ],
        ),
      ),
    );
  }
}
