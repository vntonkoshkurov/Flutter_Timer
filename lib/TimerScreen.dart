import 'package:flutter/material.dart';

import 'screens/MainScreen.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: MainScreen(),
    );
  }
}