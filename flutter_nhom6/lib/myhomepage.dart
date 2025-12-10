import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: myBody());
  }
}
Widget myBody() {
  return Center(
    child: Text("helooooooooooooo",
     style : TextStyle(color: Colors.red, fontSize: 30),
    ), 
  );
}