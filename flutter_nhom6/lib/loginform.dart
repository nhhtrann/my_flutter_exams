import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  bool _obscurePassword = true;

  String? _userError;   // lỗi tên đăng nhập
  String? _passError;   // lỗi mật khẩu

  void _login() {
    String user = _userController.text.trim();
    String pass = _passController.text.trim();

    setState(() {
      _userError = null;
      _passError = null;
    });

    bool valid = true;

    if (user.isEmpty) {
      setState(() {
        _userError = "Vui lòng nhập tên người dùng";
      });
      valid = false;
    }

    if (pass.isEmpty) {
      setState(() {
        _passError = "Vui lòng nhập mật khẩu";
      });
      valid = false;
    } else if (pass.length < 6) {
      setState(() {
        _passError = "Mật khẩu phải từ 6 ký tự trở lên";
      });
      valid = false;
    }

    if (!valid) return;

    // Thành công -> SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Đăng nhập thành công")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Đăng nhập"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ====== TÊN NGƯỜI DÙNG ======
            TextField(
              controller: _userController,
              decoration: InputDecoration(
                labelText: "Tên người dùng",
                prefixIcon: const Icon(Icons.person),
                errorText: _userError,   // lỗi dưới TextField
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ====== MẬT KHẨU ======
            TextField(
              controller: _passController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: "Mật khẩu",
                prefixIcon: const Icon(Icons.lock),

                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),

                errorText: _passError, // lỗi dưới TextField

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ====== NÚT ĐĂNG NHẬP ======
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  "Đăng nhập",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
