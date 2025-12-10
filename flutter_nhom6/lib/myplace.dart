

import 'package:flutter/material.dart';

class MyPlace extends StatelessWidget {
  const MyPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: myBody());
  }
}
Widget myBody() {
  return Column(
    children: [
      block1(),
      block2(),
      block3(),
      block4(),
    ],
  );
}  
Widget block3(){
  return Row(
    children: [
      Column(
        children: [
          Icon(Icons.call, color: Colors.blue),
          Text("Call"),
        ],
      ),
      Column(
        children: [
          Icon(Icons.near_me, color: Colors.blue),
          Text("Route"),
        ],
      ),
      Column(
        children: [
          Icon(Icons.share, color: Colors.blue),
          Text("Share"),
        ],
      ),
    ],
  );
}
Widget block2(){ 
  var title = "Hoang mac Sahara";
  var subTitle = "Chau Phi";
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
            Text(subTitle, style: TextStyle(color: Colors.grey),),
          ],
        ),
        Row(
          children: [
            Icon(Icons.star, color: Colors.red),
            Text("41"),
          ],
        )
      ],
    ),
  );
}
Widget block4(){
  var content = "Sahara là sa mạc lớn nhất trên Trái Đất, là hoang mạc lớn thứ 3 trên Trái Đất, với diện tích hơn 9.000.000 km², xấp xỉ diện tích của Hoa Kỳ và Trung Quốc. Sahara ở phía bắc châu Phi và có tới 2,5 triệu năm tuổi.";
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Text(content),
  );
}
Widget block1(){
    var src = "https://plus.unsplash.com/premium_photo-1661962542692-4fe7a4ad6b54?q=80&w=1171&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
    return Image.network(src);
  }