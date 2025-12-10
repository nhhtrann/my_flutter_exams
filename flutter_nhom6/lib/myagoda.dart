import 'package:flutter/material.dart';

class MyAgoda extends StatelessWidget {
  const MyAgoda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _myBody(),
    );
  }

  Widget _myBody() {
    // ===== DANH SÁCH CÁC KHÁCH SẠN =====
    final List<Map<String, dynamic>> hotels = [
      {
        'name': 'aHill Boutique',
        'score': 9.5,
        'rating': 'Xuất sắc',
        'reviews': 95,
        'distance': '0.6km',
        'city': 'Huế',
        'price': 'US\$109',
        'description': '1 suite riêng tư · 1 giường',
        'imagePath': 'assets/images/a5.jpg',
      },
      {
        'name': 'An Nam Boutique',
        'score': 9.2,
        'rating': 'Tuyệt hảo',
        'reviews': 34,
        'distance': '0.9km',
        'city': 'Cư Chinh',
        'price': 'US\$20',
        'description': '1 phòng khách sạn · 1 giường',
        'imagePath': 'assets/images/a6.jpg',
      },
      {
        'name': 'Huế Jade Villa',
        'score': 8.0,
        'rating': 'Rất tốt',
        'reviews': 1,
        'distance': '1.3km',
        'city': 'Cư Chinh',
        'price': 'US\$285',
        'description': '4 giường · 3 phòng ngủ · 1 phòng khách · 3 phòng tắm',
        'imagePath': 'assets/images/a7.jpg',
      },
    ];

    return Column(
      children: [
        // ===== HEADER =====
        Container(
          padding: const EdgeInsets.only(top: 40, bottom: 8, left: 8, right: 8),
          color: const Color(0xFF0077B6),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {},
              ),
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(width: 8),
                      Icon(Icons.search, color: Colors.grey, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Xung quanh vị trí hiện tại',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                '23 thg 10 – 24 thg 10',
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
            ],
          ),
        ),

        // ===== BODY =====
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _headerButton(Icons.sort, 'Sắp xếp'),
                  _headerButton(Icons.filter_list, 'Lọc'),
                  _headerButton(Icons.map_outlined, 'Bản đồ'),
                ],
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  '757 chỗ nghỉ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),

              // ===== LẶP TỪNG KHÁCH SẠN =====
              for (var h in hotels) _hotelCard(h),
            ],
          ),
        ),
      ],
    );
  }

  // ===== HÀM TẠO CARD =====
  Widget _hotelCard(Map<String, dynamic> h) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ẢNH TRÁI
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                h['imagePath'],
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),

            // CỘT PHẢI
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tên + tim
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          h['name'],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(Icons.favorite_border, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // 5 sao
                  Row(
                    children: List.generate(
                      5,
                      (index) => const Icon(Icons.star,
                          color: Colors.orange, size: 16),
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Điểm + đánh giá
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0077B6),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          h['score'].toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        h['rating'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${h['reviews']} đánh giá',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Địa điểm + khoảng cách
                  Text(
                    '${h['city']} · cách bạn ${h['distance']}',
                    style:
                        const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 4),

                  // --- CỘT PHẢI: căn lề phải ---
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          h['description'],
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          h['price'],
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0077B6),
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Đã bao gồm thuế và phí',
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // HÀM PHỤ tạo nút đầu trang
  Widget _headerButton(IconData icon, String text) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 20, color: Colors.grey[700]),
      label: Text(
        text,
        style: TextStyle(color: Colors.grey[700], fontSize: 14),
      ),
    );
  }
}
