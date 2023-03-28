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
  int h = 0;
  int m = 0;
  int s = 0;
  final List<DropdownMenuItem<dynamic>> hoursList = _intToStringConverter(24).map((String value) => DropdownMenuItem(child: Text(value), value: ArgumentError.value(value),));
  // List<DropdownMenuItem<dynamic>> minutesList = List.generate(
  //     60, (int index) => _intToStringConverter(index),
  //     growable: false);
  // List<DropdownMenuItem<dynamic>> secondsList = List.generate(
  //     60, (int index) => _intToStringConverter(index),
  //     growable: false);

  static List<String> _intToStringConverter(int index) {
    List<String> items =[];
    for (int i = 0; i<index; i++) {
      items.add(i<10? '0$i' : 'i');
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
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
            children: [
              DropdownButton(
                items: hoursList,

              ),
              DropdownMenu(
                dropdownMenuEntries: minutesList,
                hintText: 'Minutes',
                label: const Text('Minutes'),
                menuHeight: 400,
                enableFilter: false,
                enableSearch: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
