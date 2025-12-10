import 'package:flutter/material.dart';

class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int _count = 0;
  // 1. Khởi tạo biến màu mặc định (ví dụ: màu đen)
  Color _countColor = Colors.black; 

  void _increase() {
    setState(() {
      _count++;
      // Đặt màu xanh lá khi TĂNG
      _countColor = Colors.green; 
    });
  }

  void _decrease() {
    setState(() {
      _count--;
      // Đặt màu đỏ khi GIẢM
      _countColor = Colors.redAccent; 
    });
  }

  void _reset() {
    setState(() {
      _count = 0;
      // Đặt màu xám hoặc màu đen khi ĐẶT LẠI
      _countColor = Colors.grey; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ứng dụng điểm số (Counter App)',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: myBody(),
    );
  }

  Widget myBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Điểm số hiện tại:",
            style: TextStyle(fontSize: 24),
          ),
          Text(
            '$_count',
            // 2. Sử dụng biến màu (_countColor) trong TextStyle
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: _countColor, // Dùng biến màu ở đây
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _decrease,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                child: const Text("- Giảm", style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: _reset,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
                child: const Text("Đặt lại", style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: _increase,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text("+ Tăng", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}