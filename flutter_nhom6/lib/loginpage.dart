import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Form Đăng nhập',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false; // trạng thái đang gọi API

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  // HÀM GỌI API LOGIN DUMMYJSON
  Future<void> _onLogin() async {
    // validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    setState(() {
      _isLoading = true;
    });

    try {
      // 1. GỌI API LOGIN
      final uri = Uri.parse('https://dummyjson.com/auth/login');

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
          'expiresInMins': 30,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Lấy accessToken (nếu cần dùng tiếp cho /auth/me)
        final accessToken = data['accessToken'] as String?;

        if (accessToken == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Không lấy được accessToken')),
          );
          return;
        }

        // Ở đây dummyjson đã trả luôn thông tin user (id, username, email, firstName, lastName, image...)
        // => ta dùng dữ liệu này làm profile và truyền sang màn ProfilePage

        // Tạo 1 map profile đơn giản từ data
        final profile = {
          'id': data['id'],
          'username': data['username'],
          'email': data['email'],
          'firstName': data['firstName'],
          'lastName': data['lastName'],
          'gender': data['gender'],
          'image': data['image'],
        };

        // Thông báo + chuyển màn
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Đăng nhập thành công')));

        // Điều hướng sang trang ProfilePage
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(profile: profile),
          ),
        );
      } else {
        // Login thất bại (ví dụ sai username / password)
        // API dummyjson trả message trong body
        String message = 'Đăng nhập thất bại';
        try {
          final errData = jsonDecode(response.body);
          if (errData['message'] != null) {
            message = errData['message'];
          }
        } catch (_) {}
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    } catch (e) {
      // Lỗi mạng, lỗi server...
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Đăng nhập'), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // gắn key cho Form
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ---- TÊN NGƯỜI DÙNG ----
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Tên người dùng',
                    hintText: 'Vui lòng nhập tên người dùng',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập tên người dùng';
                    }
                    return null; // hợp lệ
                  },
                ),
                const SizedBox(height: 16.0),

                // ---- MẬT KHẨU ----
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword, // ẩn / hiện mật khẩu
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    hintText: 'Vui lòng nhập mật khẩu',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mật khẩu';
                    }
                    if (value.length < 3) {
                      // dummyjson dùng pass khá ngắn, đừng check 6 ký tự
                      return 'Mật khẩu phải >= 3 ký tự';
                    }
                    return null; // hợp lệ
                  },
                ),
                const SizedBox(height: 24.0),

                // ---- NÚT ĐĂNG NHẬP ----
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _onLogin,
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Text(
                            'Đăng nhập',
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ====== TRANG HIỂN THỊ PROFILE ======

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> profile;

  const ProfilePage({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final fullName =
        '${profile['firstName'] ?? ''} ${profile['lastName'] ?? ''}'.trim();

    return Scaffold(
      appBar: AppBar(title: const Text('Thông tin người dùng')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Ảnh avatar
            if (profile['image'] != null)
              CircleAvatar(
                radius: 48,
                backgroundImage: NetworkImage(profile['image']),
              ),
            const SizedBox(height: 16),

            // Tên đầy đủ
            Text(
              fullName.isEmpty ? 'Không có tên' : fullName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // Username
            Text(
              '@${profile['username'] ?? ''}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 16),

            // Email
            Row(
              children: [
                const Icon(Icons.email),
                const SizedBox(width: 8),
                Expanded(child: Text(profile['email'] ?? 'Không có email')),
              ],
            ),

            const SizedBox(height: 8),

            // Giới tính
            Row(
              children: [
                const Icon(Icons.person),
                const SizedBox(width: 8),
                Text('Giới tính: ${profile['gender'] ?? 'N/A'}'),
              ],
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
