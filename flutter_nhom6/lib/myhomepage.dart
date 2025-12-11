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
    child: Text("Flutter",
     style : TextStyle(color: const Color.fromARGB(255, 54, 108, 244), fontSize: 30),
    ), 
  );
}