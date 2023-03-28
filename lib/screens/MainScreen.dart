import 'package:flutter/material.dart';

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
  String timeString = '00:00:00';
  String menuValHours = '00';
  String menuValMinutes = '00';
  String menuValSeconds = '00';
  final String buttonStart = 'Start';
  final String buttonStop = 'Stop';
  final String buttonReset = 'Reset';
  late String buttonLabelState;

  int h = 0;
  int m = 0;
  int s = 0;
  int timer = 0;
  bool isStarted = false;

  final List<DropdownMenuItem<dynamic>> hoursList = _intToStringConverter(24)
      .map((value) => DropdownMenuItem(value:value, child: Text(value)))
      .toList();

  final List<DropdownMenuItem<dynamic>> minuteList = _intToStringConverter(60)
      .map((value) => DropdownMenuItem(value:value, child: Text(value)))
      .toList();

  final List<DropdownMenuItem<dynamic>> secondList = _intToStringConverter(60)
      .map((value) => DropdownMenuItem(value:value, child: Text(value)))
      .toList();

  static List<String> _intToStringConverter(int index) {
    List<String> items = [];
    for (int i = 0; i < index; i++) {
      items.add(i < 10 ? '0$i' : '$i');
    }
    return items;
  }

  String makeTimeString ({required int h,
    required int m,
    required int s}) {

    String res = (h < 10 ? '0$h' : '$h') + ':' + (m < 10 ? '0$m' : '$m') + ':' + (s < 10 ? '0$s' : '$s');

    return res;

  }

  int valToSeconds ({required int h,
    required int m,
    required int s}) {
    return h * 3600 + m * 60 + s;
  }

  void secTovals ({required int sec}) {
    s = sec % 60;
    h = sec ~/ 60;
    m = h % 60;
    h = h ~/ 60;
  }

  @override
  void initState() {
    buttonLabelState = buttonStart;
    timer = valToSeconds(h: h, m: m, s: s);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isStarted) {
      setState(() {
      timer--;
      secTovals(sec: timer);
      timeString = makeTimeString(h: h, m: m, s: s);
    });
    }
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            timeString,
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
                  SizedBox(height: 5,),
                  Container(
                    width: 60,
                    padding: EdgeInsets.only(
                        left: 5,
                        right: 5,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: Colors.black26,
                          width: 2),
                    ),
                    child: DropdownButton(
                      menuMaxHeight: 300,
                      elevation: 8,
                      value: menuValHours,
                      items: hoursList,
                      onChanged: (value) {
                        setState(() {
                          menuValHours = value;
                          h = int.parse(value);
                          timeString = makeTimeString(h: h, m: m, s: s);
                          timer = valToSeconds(h: h, m: m, s: s);
                        });
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
                  SizedBox(height: 5,),
                  Container(
                    width: 60,
                    padding: EdgeInsets.only(
                      left: 5,
                      right: 5,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: Colors.black26,
                          width: 2),
                    ),
                    child: DropdownButton(
                      menuMaxHeight: 300,
                      elevation: 8,
                      value: menuValMinutes,
                      items: minuteList,
                      onChanged: (value) {
                        setState(() {
                          menuValMinutes = value;
                          m = int.parse(value);
                          timeString = makeTimeString(h: h, m: m, s: s);
                          timer = valToSeconds(h: h, m: m, s: s);
                        });
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
                  SizedBox(height: 5,),
                  Container(
                    width: 60,
                    padding: EdgeInsets.only(
                      left: 5,
                      right: 5,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: Colors.black26,
                          width: 2),
                    ),
                    child: DropdownButton(
                      menuMaxHeight: 300,
                      elevation: 8,
                      value: menuValSeconds,
                      items: secondList,
                      onChanged: (value) {
                        setState(() {
                          menuValSeconds = value;
                          s = int.parse(value);
                          timeString = makeTimeString(h: h, m: m, s: s);
                          timer = valToSeconds(h: h, m: m, s: s);
                        });
                      },
                    ),
                  ),
                ],
              ),
              //CommandBotton
              const SizedBox(width: 20)
            ],
          ),
          SizedBox(height: 20,),
          Center(
            child: TextButton(
              onPressed: () {
                setState(() {
                  if (!isStarted) {
                    isStarted = true;
                    timer--;
                    secTovals(sec: timer);
                    timeString = makeTimeString(h: h, m: m, s: s);
                  } else {
                    isStarted = false;
                  }
                });
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.blue,
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                ),
              child: Text(buttonLabelState),
            ),
          ),
          SizedBox(height: 5,),
          Center(
            child: TextButton(
              onPressed: () {

              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.blue,
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              child: Text(buttonReset),
            ),
          ),
        ],
      ),
    );
  }
}
