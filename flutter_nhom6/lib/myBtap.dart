import 'package:flutter/material.dart';
import 'package:flutter_nhom6/loginpage.dart';

import 'myhomepage.dart';
import 'myplace.dart';
import 'myagoda.dart';
import 'myguide.dart';
import 'mylist.dart';
import 'my_product.dart';
import 'doimaunen.dart';
import 'counter_app.dart';
import 'Countdown_Timer.dart';
import 'loginform.dart';
import 'registerform.dart';
import 'screens/news_list.dart';

class Exercise {
  final String title;
  final Widget screen;

  Exercise(this.title, this.screen);
}

class MyBtap extends StatefulWidget {
  const MyBtap({super.key});

  @override
  State<MyBtap> createState() => _SplitScreenState();
}

class _SplitScreenState extends State<MyBtap> {
  final List<Exercise> exercises = [
    Exercise("Test ngày đầu Flutter", const MyHomePage()),
    Exercise("Hoang mạc Saharah", const MyPlace()),
    Exercise("Danh sách chỗ nghỉ Agoda", const MyAgoda()),
    Exercise("My Guide", const MyGuide()),
    Exercise("Danh sách lớp học", const MyList()),
    Exercise("Đổi màu nền", const Doimaunen()),
    Exercise("Ứng dụng đếm số", const CounterApp()),
    Exercise("Bộ đếm thời gian", const CountdownTimer()),
    Exercise("Đăng nhập (Form Login)", const LoginForm()),
    Exercise("Đăng ký (Form Register)", const RegisterForm()),
    Exercise("Danh sách sản phẩm", const MyProduct()),
    Exercise("Danh sách & Chi tiết (News)", const NewsListScreen()),
    Exercise("Đăng nhập (Postman)", const LoginPage()),
  ];

  Widget? _currentScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            setState(() {
              _currentScreen = null;
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.home, size: 28),
              SizedBox(width: 10),
              Text(
                "Trang chủ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: [
          Center(
            child: Text(
              "Nguyễn Hoàng Huyền Trân",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 10), 
          const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 18,
            child: Icon(Icons.pets, color: Colors.blue),
          ),
          const SizedBox(width: 20),
        ],

        backgroundColor: const Color.fromARGB(255, 214, 127, 220),
        foregroundColor: Colors.white,
      ),
      body: Row(
        children: [
          Container(
            width: 300,
            color: Colors.grey[100],
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.blue[50],
                  child: Row(
                    children: const [
                      Icon(Icons.folder_copy, color: const Color.fromARGB(255, 214, 127, 220)),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Danh sách bài tập",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 219, 144, 230)),
                        ),
                      ),
                    ],
                  ),
                ),
                
                Expanded(
                  child: ListView.separated(
                    itemCount: exercises.length,
                    separatorBuilder: (ctx, i) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final item = exercises[index];
                      final isSelected = item.screen == _currentScreen;

                      return ListTile(
                        tileColor: isSelected ? const Color.fromARGB(255, 205, 103, 190).withOpacity(0.1) : null,
                        title: Text(
                          item.title,
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? const Color.fromARGB(255, 199, 124, 209) : Colors.black,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _currentScreen = item.screen;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          const VerticalDivider(width: 1, thickness: 1, color: Colors.grey),

          Expanded(
            child: Container(
              color: Colors.white,
              child: ClipRect(
                child: _currentScreen ?? _buildWelcomeScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Chọn một bài tập từ danh sách bên trái",
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}