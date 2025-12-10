import 'package:flutter/material.dart';

// 1. Model để chứa thông tin của một lớp học
class ClassInfo {
  final String title;
  final String subtitle;
  final String studentCount;
  final String bgImage;

  ClassInfo({
    required this.title,
    required this.subtitle,
    required this.studentCount,
    required this.bgImage,
  });
}

// 2. Dữ liệu giả lập giống như trong hình ảnh bạn gửi
final List<ClassInfo> mockData = [
  ClassInfo(
    title: "XML và ứng dụng - Nhóm 1",
    subtitle: "2025-2026.1.TIN4583.001",
    studentCount: "58 học viên",
    bgImage: "assets/images/a8.jpg",
  ),
  ClassInfo(
    title: "Lập trình ứng dụng cho các t...",
    subtitle: "2025-2026.1.TIN4403.006",
    studentCount: "55 học viên",
    bgImage: "assets/images/a11.jpg",
  ),
  ClassInfo(
    title: "Lập trình ứng dụng cho các t...",
    subtitle: "2025-2026.1.TIN4403.005",
    studentCount: "52 học viên",
    bgImage: "assets/images/a10.jpg",
  ),
  ClassInfo(
    title: "Lập trình ứng dụng cho các t...",
    subtitle: "2025-2026.1.TIN4403.004",
    studentCount: "50 học viên",
    bgImage: "assets/images/a9.jpg",
  ),
  ClassInfo(
    title: "Lập trình ứng dụng cho các t...",
    subtitle: "2025-2026.1.TIN4403.003",
    studentCount: "52 học viên",
    bgImage: "assets/images/a11.jpg",
  ),
];

class MyList extends StatelessWidget {
  const MyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        color: Colors.white, // Nền chung của ứng dụng
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: mockData.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12), // Khoảng cách giữa các item
          itemBuilder: (context, index) {
            // Render từng thẻ lớp học
            return ClassroomCard(info: mockData[index]);
          },
        ),
      ),
    );
  }
}

class ClassroomCard extends StatelessWidget {
  final ClassInfo info;

  const ClassroomCard({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        // --- PHẦN QUAN TRỌNG NHẤT Ở ĐÂY ---
        image: DecorationImage(
          image: AssetImage(info.bgImage), // Load ảnh từ assets
          fit: BoxFit.cover, // Căng ảnh ra phủ kín toàn bộ khung
          // Nếu ảnh quá sáng, bạn có thể thêm lớp phủ màu tối để chữ dễ đọc hơn:
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.2), 
            BlendMode.darken
          ),
        ),
        // -----------------------------------
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Title + Menu Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        info.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        info.subtitle,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
            
            const Spacer(), // Đẩy phần student xuống đáy
            
            // Footer: Student count
            Text(
              info.studentCount,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}