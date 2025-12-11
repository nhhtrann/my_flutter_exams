import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const Doimaunen());
}

class Doimaunen extends StatefulWidget {
  const Doimaunen({super.key});

  @override
  State<Doimaunen> createState() => _ColorChangeAppState();
}

class _ColorChangeAppState extends State<Doimaunen> {
  // 1. Tạo danh sách các cặp Màu - Tên màu
  final List<Map<String, dynamic>> _colorList = [
    {'color': Colors.blue, 'name': 'Màu Xanh Dương'},
    {'color': Colors.red, 'name': 'Màu Đỏ'},
    {'color': Colors.green, 'name': 'Màu Xanh Lá'},
    {'color': Colors.yellow, 'name': 'Màu Vàng'},
    {'color': Colors.orange, 'name': 'Màu Cam'},
    {'color': Colors.purple, 'name': 'Màu Tím'},
    {'color': Colors.pink, 'name': 'Màu Hồng'},
    {'color': Colors.black, 'name': 'Màu Đen'},
    {'color': Colors.brown, 'name': 'Màu Nâu'},
  ];

  // Khởi tạo màu mặc định
  Color _backgroundColor = Colors.blue;
  String _colorName = "Màu Xanh Dương";

  void _changeColor() {
    setState(() {
      // 2. Lấy ngẫu nhiên một màu trong danh sách trên
      int randomIndex = Random().nextInt(_colorList.length);
      
      _backgroundColor = _colorList[randomIndex]['color'];
      _colorName = _colorList[randomIndex]['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // Kiểm tra nếu màu nền là màu sáng (Vàng/Trắng) thì đổi chữ thành màu đen cho dễ đọc
    Color textColor = (_backgroundColor == Colors.yellow || _backgroundColor == Colors.white) 
        ? Colors.black 
        : Colors.white;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: _backgroundColor,
        appBar: AppBar(
          title: const Text(
            "Ứng dụng đổi màu nền",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 197, 139, 211),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Màu hiện tại:",
                style: TextStyle(fontSize: 20, color: textColor),
              ),
              const SizedBox(height: 10),
              
              // 3. Hiển thị tên màu thay vì mã HEX
              Text(
                _colorName, 
                style: TextStyle(
                    fontSize: 30, // Tăng kích thước chữ cho đẹp
                    fontWeight: FontWeight.bold,
                    color: textColor),
              ),
              
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _changeColor,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Nút màu trắng
                  foregroundColor: Colors.black, // Chữ nút màu đen
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text("Đổi màu nền", style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}