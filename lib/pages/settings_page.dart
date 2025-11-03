import 'package:flutter/material.dart';
import 'package:hng_stage_3/design_widgets/nav_bar_widget.dart';

class MySettings extends StatefulWidget{
  const MySettings({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MySettings ();
  }

}

class _MySettings  extends State<MySettings>{
  String selectedValue = 'Option 1';
  bool isSwitched = false;

  final List<String> options = ['Option 1', 'Option 2', 'Option 3'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          NavBar(),
          Text("settings"),
          SizedBox(
            child: Column(
              children: [
                SizedBox(
                  child: DropdownButton<String>(
                    value: selectedValue,
                    icon: Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    items: options.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(child: Column(
                  children: [
                    Text(isSwitched ? 'ON' : 'OFF'),
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.grey,
                    ),
                  ],
                ),),
              ]
            ),
          )
        ],
      )),
    );
  }
}