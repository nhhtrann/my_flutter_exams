import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  final TextEditingController _confirmCtrl = TextEditingController();

  String? _nameError;
  String? _emailError;
  String? _passError;
  String? _confirmError;

  bool _hidePass = true;
  bool _hideConfirm = true;

  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  void _register() {
    setState(() {
      _nameError = null;
      _emailError = null;
      _passError = null;
      _confirmError = null;
    });

    String name = _nameCtrl.text.trim();
    String email = _emailCtrl.text.trim();
    String pass = _passCtrl.text.trim();
    String confirm = _confirmCtrl.text.trim();

    bool valid = true;

    if (name.isEmpty) {
      _nameError = "Vui lòng nhập họ tên";
      valid = false;
    }

    if (email.isEmpty) {
      _emailError = "Vui lòng nhập email";
      valid = false;
    } else if (!_isValidEmail(email)) {
      _emailError = "Email không đúng định dạng";
      valid = false;
    }

    if (pass.isEmpty) {
      _passError = "Vui lòng nhập mật khẩu";
      valid = false;
    } else if (pass.length < 6) {
      _passError = "Mật khẩu phải từ 6 ký tự";
      valid = false;
    }

    if (confirm.isEmpty) {
      _confirmError = "Vui lòng xác nhận mật khẩu";
      valid = false;
    } else if (confirm != pass) {
      _confirmError = "Mật khẩu không khớp";
      valid = false;
    }

    if (!valid) {
      setState(() {});
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Đăng ký thành công")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text(
    "Form Đăng ký tài khoản",
    style: TextStyle(color: Colors.white, fontSize: 18),
  ),
  backgroundColor: const Color.fromARGB(255, 63, 46, 172),
  centerTitle: true,
),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Họ tên
            TextField(
              controller: _nameCtrl,
              decoration: InputDecoration(
                labelText: "Họ tên",
                prefixIcon: const Icon(Icons.person),
                errorText: _nameError,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),

            // Email
            TextField(
              controller: _emailCtrl,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: const Icon(Icons.email),
                errorText: _emailError,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),

            // Mật khẩu
            TextField(
              controller: _passCtrl,
              obscureText: _hidePass,
              decoration: InputDecoration(
                labelText: "Mật khẩu",
                prefixIcon: const Icon(Icons.lock),
                errorText: _passError,
                suffixIcon: IconButton(
                  icon: Icon(_hidePass ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() => _hidePass = !_hidePass);
                  },
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),

            // Xác nhận mật khẩu
            TextField(
              controller: _confirmCtrl,
              obscureText: _hideConfirm,
              decoration: InputDecoration(
                labelText: "Xác nhận mật khẩu",
                prefixIcon: const Icon(Icons.lock_outline),
                errorText: _confirmError,
                suffixIcon: IconButton(
                  icon: Icon(_hideConfirm ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() => _hideConfirm = !_hideConfirm);
                  },
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 30),

            // Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 63, 46, 172),
                ),
                child: const Text(
                  "Đăng ký",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
