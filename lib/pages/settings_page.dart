import 'package:flutter/material.dart';

class MySettings extends StatefulWidget{
  const MySettings({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MySettings ();
  }

}

class _MySettings  extends State<MySettings>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: child),
    );
  }
}