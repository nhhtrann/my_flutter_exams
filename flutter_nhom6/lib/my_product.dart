import 'package:flutter/material.dart';
import 'package:flutter_nhom6/api/api.dart';
import 'package:flutter_nhom6/product.dart';

class MyProduct extends StatefulWidget {
  const MyProduct({super.key});

  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách sản phẩm"),
        backgroundColor: Colors.blue,
      ),

      body: FutureBuilder<List<Product>>(
        future: test_api.getAllProduct(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snap.hasError) {
            return const Center(child: Text("Lỗi tải dữ liệu !"));
          }

          var products = snap.data ?? [];

          return ListView.builder(
            itemCount: products.length,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return productCard(products[index]);
            },
          );
        },
      ),
    );
  }

  Widget productCard(Product p) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // --- ẢNH SẢN PHẨM ---
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                p.image,
                height: 90,
                width: 90,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 15),

            // --- THÔNG TIN SẢN PHẨM ---
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "\$${p.price}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    p.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
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
}
