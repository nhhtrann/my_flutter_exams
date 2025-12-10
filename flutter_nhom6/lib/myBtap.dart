import 'package:flutter/material.dart';
import 'package:flutter_nhom6/loginpage.dart';

// --- 1. IMPORT CÁC FILE BÀI TẬP CỦA BẠN TẠI ĐÂY ---
// (Hãy đảm bảo tên file và đường dẫn đúng với dự án của bạn)
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
import 'myBtap.dart';

// --- 2. CẤU HÌNH MENU ---
class Exercise {
  final String title;     // Tên hiển thị trên Menu
  final Widget screen;    // Màn hình sẽ hiện ra (Class của bài tập)

  Exercise(this.title, this.screen);
}

class MyBtap extends StatefulWidget {
  const MyBtap({super.key});

  @override
  State<MyBtap> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<MyBtap> {
  
  // Danh sách các bài tập (Bạn thêm bớt bài tập ở đây)
  final List<Exercise> exercises = [
    // [Tên hiển thị] - [Tên Class màn hình tương ứng]
    Exercise("Test ngày đầu Flutter", const MyHomePage()), 
    Exercise("Hoang mạc Saharah", const MyPlace()),
    Exercise("Danh sách chỗ nghỉ Agoda", const MyAgoda()),
    Exercise("My Guide", const MyGuide()), 
    Exercise("Danh sách lớp học", const MyList()),
    Exercise("Đổi màu nền", const Doimaunen()), 
    Exercise("Ứng dụng đếm số", const CounterApp()), 
    Exercise("Bộ đếm thời gian", const CountdownTimer()), 
    Exercise("Đăng nhập (Form Login)", const LoginForm()), // Giả sử class trong loginform.dart là LoginForm
    Exercise("Đăng ký (Form Register)", const RegisterForm()), 
    Exercise("Danh sách sản phẩm ", const MyProduct()), 
    Exercise("Danh sách sản phẩm và chi tiết", const NewsListScreen()), 
    Exercise("Đăng nhập (Postman)", const LoginPage()),
  ];

  // Biến lưu màn hình đang chọn. Mặc định là null (Màn hình chờ)
  Widget? _currentScreen;
  String _currentTitle = "Hệ thống học tập"; // Tiêu đề mặc định

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentTitle),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      
      // --- MENU BÊN TRÁI (DRAWER) ---
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.blue[900]),
              accountName: const Text("Nguyễn Hoàng Huyền Trân"),
              accountEmail: const Text("Danh sách các bài đã làm"),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.folder_copy, size: 40, color: Colors.blue),
              ),
            ),
            
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: exercises.length,
                separatorBuilder: (ctx, i) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = exercises[index];
                  
                  return ListTile(
                    leading: const Icon(Icons.code), // Icon code cho mọi bài
                    title: Text(item.title),
                    onTap: () {
                      // Khi bấm vào bài tập:
                      setState(() {
                        _currentScreen = item.screen; // 1. Đổi nội dung body
                        _currentTitle = item.title;   // 2. Đổi tiêu đề Appbar (nếu muốn)
                      });
                      Navigator.pop(context); // 3. Đóng Drawer
                    },
                  );
                },
              ),
            ),

            // Nút reset về màn hình chờ
            const Divider(),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.red),
              title: const Text("Về màn hình chính"),
              onTap: () {
                setState(() {
                  _currentScreen = null;
                  _currentTitle = "Hệ thống học tập";
                });
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),

      // --- NỘI DUNG CHÍNH (BODY) ---
      // Nếu _currentScreen có dữ liệu (đã chọn bài) thì hiển thị bài đó
      // Nếu chưa chọn thì hiển thị màn hình chờ (buildEmptyState)
      body: _currentScreen ?? buildEmptyState(),
    );
  }

  // Màn hình chờ khi chưa chọn bài tập nào
  Widget buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.flutter_dash, size: 100, color: Colors.blue[200]),
          const SizedBox(height: 20),
          const Text(
            "Vui lòng chọn bài tập từ Menu",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          
          
        ],
      ),
    );
  }
}