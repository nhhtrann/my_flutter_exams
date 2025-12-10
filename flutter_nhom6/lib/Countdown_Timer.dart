import 'package:flutter/material.dart';
import 'dart:async'; // Cần import thư viện này để sử dụng Timer

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  State<CountdownTimer> createState() => _CountdownTimerAppState();
}

class _CountdownTimerAppState extends State<CountdownTimer> {
  // Gợi ý 1: Dùng TextEditingController cho ô nhập liệu
  final TextEditingController _inputController = TextEditingController();
  
  // Biến trạng thái
  int _secondsRemaining = 0;
  Timer? _timer;
  String _statusMessage = 'Sẵn sàng';
  bool _isRunning = false;

  @override
  void dispose() {
    // Gợi ý 3: Hủy Timer trong dispose() để tránh rò rỉ bộ nhớ
    _timer?.cancel();
    _inputController.dispose();
    super.dispose();
  }

  // --- LOGIC ĐIỀU KHIỂN ---

  void _startTimer() {
    // 1. Lấy giá trị đầu vào và kiểm tra hợp lệ
    final inputSeconds = int.tryParse(_inputController.text);

    if (_isRunning) {
      // Đang chạy, không làm gì cả
      return;
    }

    if (inputSeconds == null || inputSeconds <= 0) {
      setState(() {
        _statusMessage = 'Vui lòng nhập số giây hợp lệ!';
      });
      return;
    }

    // 2. Thiết lập trạng thái ban đầu
    setState(() {
      _secondsRemaining = inputSeconds;
      _isRunning = true;
      _statusMessage = 'Đang đếm ngược...';
    });

    // 3. Gợi ý 2: Dùng Timer.periodic để đếm ngược
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        // Đếm ngược (mỗi giây giảm 1)
        setState(() {
          _secondsRemaining--;
        });
      } else {
        // 4. Khi hết giờ: Hủy Timer và hiển thị thông báo
        timer.cancel();
        setState(() {
          _isRunning = false;
          _statusMessage = '🎉 Hết thời gian!';
        });
        
        // Hiển thị thông báo (Dialog)
        _showFinishedDialog();
      }
    });
  }

  void _stopTimer() {
    if (_isRunning) {
      _timer?.cancel();
      setState(() {
        _isRunning = false;
        _statusMessage = 'Đã dừng ở $_secondsRemaining giây.';
      });
    }
  }

  // --- HIỂN THỊ HỘP THOẠI KHI HẾT GIỜ ---

  void _showFinishedDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hoàn thành!'),
          content: const Text('🎉 Hết thời gian!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Đặt lại trạng thái sau khi đóng dialog
                setState(() {
                  _statusMessage = 'Đã hoàn thành.';
                  _secondsRemaining = 0;
                  _inputController.clear();
                });
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // --- UI/GIAO DIỆN ---
  
  // Định dạng thời gian hiển thị (MM:SS)
  String _formatTime(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bộ đếm thời gian'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Ô NHẬP LIỆU
              TextField(
                controller: _inputController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Nhập số giây cần đếm (ví dụ: 10)',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.timer),
                ),
                enabled: !_isRunning, // Không cho sửa khi đang chạy
              ),
              const SizedBox(height: 40),

              // HIỂN THỊ THỜI GIAN
              Text(
                _formatTime(_secondsRemaining),
                style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.deepOrange),
              ),
              const SizedBox(height: 20),
              
              // TRẠNG THÁI
              Text(
                _statusMessage,
                style: TextStyle(fontSize: 18, color: _isRunning ? Colors.green : Colors.black87),
              ),
              const SizedBox(height: 40),

              // NÚT BẤM
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Nút BẮT ĐẦU
                  ElevatedButton.icon(
                    onPressed: _isRunning ? null : _startTimer, // Bị vô hiệu hóa khi đang chạy
                    icon: const Icon(Icons.play_arrow, color: Colors.white),
                    label: const Text('Bắt đầu', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                  const SizedBox(width: 20),

                  // Nút DỪNG
                  ElevatedButton.icon(
                    onPressed: _isRunning ? _stopTimer : null, // Chỉ hoạt động khi đang chạy
                    icon: const Icon(Icons.stop, color: Colors.white),
                    label: const Text('Dừng', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}