import 'package:flutter/material.dart';

class MyGuide extends StatelessWidget {
  const MyGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myBody(),
    );
  }
}

Widget myBody() {
  return Padding(
    padding: const EdgeInsets.all(25.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hàng icon
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none),
              iconSize: 28,
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.extension),
              iconSize: 28,
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 30),

        // Text Welcome, Charlie
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome,",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Text(
              "Charlie",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),

        // Ô tìm kiếm
        TextField(
          decoration: InputDecoration(
            hintText: "Search...",
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 25),

        // Tiêu đề Saved Places
        const Text(
          "Saved Places",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),

        // GridView hình ảnh (ảnh thu nhỏ lại)
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1, // điều chỉnh tỉ lệ khung (ảnh nhỏ lại)
            children: [
              for (final img in ['a1', 'a2', 'a3', 'a4'])
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0), // thu nhỏ nhẹ
                    child: Image.asset(
                      'assets/images/$img.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}
