import 'package:flutter/material.dart';
import 'dart:async';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  State<CountdownTimer> createState() => _CountdownTimerAppState();
}

class _CountdownTimerAppState extends State<CountdownTimer> {
  final TextEditingController _inputController = TextEditingController();
  
  int _secondsRemaining = 0;
  Timer? _timer;
  String _statusMessage = 'Sẵn sàng';
  bool _isRunning = false;

  @override
  void dispose() {
    _timer?.cancel();
    _inputController.dispose();
    super.dispose();
  }

  // --- LOGIC ĐIỀU KHIỂN ---

  void _startTimer() {
    final inputSeconds = int.tryParse(_inputController.text);

    if (_isRunning) return;

    if (inputSeconds == null || inputSeconds <= 0) {
      setState(() {
        _statusMessage = 'Vui lòng nhập số giây hợp lệ!';
      });
      return;
    }

    setState(() {
      _secondsRemaining = inputSeconds;
      _isRunning = true;
      _statusMessage = 'Đang đếm ngược...';
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
        setState(() {
          _isRunning = false;
          _statusMessage = '🎉 Hết thời gian!';
        });
        _showFinishedDialog();
      }
    });
  }

  void _stopTimer() {
    if (_isRunning) {
      _timer?.cancel();
      setState(() {
        _isRunning = false;
        _statusMessage = 'Đã tạm dừng.';
      });
    }
  }

  // --- HÀM MỚI: RESET ---
  void _resetTimer() {
    _timer?.cancel(); // Dừng bộ đếm nếu đang chạy
    setState(() {
      _secondsRemaining = 0; // Về 0
      _isRunning = false; // Tắt trạng thái chạy
      _statusMessage = 'Sẵn sàng'; // Reset thông báo
      _inputController.clear(); // Xóa ô nhập liệu
    });
  }

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
                _resetTimer(); // Tự động reset khi bấm OK
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

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
        child: SingleChildScrollView( // Thêm ScrollView để tránh lỗi bàn phím che nút
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
                    labelText: 'Nhập số giây (ví dụ: 60)',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.timer),
                  ),
                  enabled: !_isRunning,
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
          
                // HÀNG CÁC NÚT BẤM
                Wrap( // Dùng Wrap thay Row để tự xuống dòng nếu màn hình nhỏ
                  spacing: 10, // Khoảng cách ngang
                  runSpacing: 10, // Khoảng cách dọc
                  alignment: WrapAlignment.center,
                  children: [
                    // Nút BẮT ĐẦU
                    ElevatedButton.icon(
                      onPressed: _isRunning ? null : _startTimer,
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Bắt đầu'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
          
                    // Nút DỪNG
                    ElevatedButton.icon(
                      onPressed: _isRunning ? _stopTimer : null,
                      icon: const Icon(Icons.pause),
                      label: const Text('Dừng'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange, // Đổi màu cam cho dễ nhìn
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
          
                    // --- NÚT RESET (MỚI) ---
                    ElevatedButton.icon(
                      onPressed: () {
                        // Cho phép reset kể cả khi đang chạy hoặc đã dừng
                        _resetTimer();
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Đặt lại'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey, // Màu xám để phân biệt
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}