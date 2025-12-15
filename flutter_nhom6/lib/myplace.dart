import 'package:flutter/material.dart';

class MyPlace extends StatelessWidget {
  const MyPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: myBody());
  }
}

Widget myBody() {
  // 1. Bọc Column trong SingleChildScrollView để sửa lỗi tràn màn hình
  return SingleChildScrollView(
    child: Column(
      children: [
        block1(),
        block2(),
        block3(),
        block4(),
      ],
    ),
  );
}

Widget block3() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0), // Thêm khoảng cách trên dưới chút cho đẹp
    child: Row(
      // 2. Căn đều các nút Call, Route, Share ra giữa
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
      children: [
        _buildButtonColumn(Icons.call, "Call"),
        _buildButtonColumn(Icons.near_me, "Route"),
        _buildButtonColumn(Icons.share, "Share"),
      ],
    ),
  );
}

// Hàm phụ để tạo nút bấm cho gọn code (không bắt buộc, nhưng nên dùng)
Column _buildButtonColumn(IconData icon, String label) {
  return Column(
    children: [
      Icon(icon, color: Colors.blue),
      const SizedBox(height: 8), // Khoảng cách giữa icon và chữ
      Text(
        label,
        style: const TextStyle(
          color: Colors.blue, 
          fontWeight: FontWeight.w400
        ),
      ),
    ],
  );
}

Widget block2() {
  var title = "Hoang mạc Sahara";
  var subTitle = "Chau Phi";
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              subTitle,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        Row(
          children: const [
            Icon(Icons.star, color: Colors.red),
            Text("41"),
          ],
        )
      ],
    ),
  );
}

Widget block4() {
  var content =
      "Sahara là sa mạc lớn nhất trên Trái Đất, là hoang mạc lớn thứ 3 trên Trái Đất, với diện tích hơn 9.000.000 km², xấp xỉ diện tích của Hoa Kỳ và Trung Quốc. Sahara ở phía bắc châu Phi và có tới 2,5 triệu năm tuổi.";
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Text(
      content,
      softWrap: true, // Cho phép tự xuống dòng
    ),
  );
}

Widget block1() {
  var src =
      "https://plus.unsplash.com/premium_photo-1661962542692-4fe7a4ad6b54?q=80&w=1171&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
  return Image.network(
    src,
    width: double.infinity, // Đảm bảo ảnh rộng full màn hình
    height: 240,            // Cố định chiều cao ảnh để layout đẹp hơn
    fit: BoxFit.cover,      // Cắt ảnh cho vừa khung
  );
}