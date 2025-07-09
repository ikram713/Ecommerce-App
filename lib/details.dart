import 'package:flutter/material.dart';

class ItemsDetails extends StatefulWidget {
  final dynamic data;

  const ItemsDetails({super.key, required this.data});

  @override
  State<ItemsDetails> createState() => _ItemsDetailsState();
}

class _ItemsDetailsState extends State<ItemsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: EndDrawerButton(),
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart, size: 28, color: Colors.black),
            SizedBox(width: 5),
            Text(
              "Detail",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "Mart",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD2A210),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.grey[200],
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 28,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Product Image
          Container(
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[300],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child:Image.network(
                widget.data['image'],  // full URL from backend
                  fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.broken_image, size: 100);
                  },
                )
            ),
          ),

          const SizedBox(height: 20),

          // Product Name
          Text(
            widget.data['name'],
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 10),

          // Product Description
          Text(
            widget.data['description'],
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 10),

          // Product Price
          Text(
            '${widget.data['price']}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFC727),
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),

          // Color options
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Color: ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              _buildColorCircle(Colors.grey, selected: true),
              const SizedBox(width: 5),
              Text("Grey", style: TextStyle(color: Colors.grey[700])),
              const SizedBox(width: 15),
              _buildColorCircle(Colors.black),
              const SizedBox(width: 5),
              Text("Black", style: TextStyle(color: Colors.grey[700])),
            ],
          ),

          const SizedBox(height: 20),

          // Size Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Size: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              ...[38, 39, 40, 41, 42].map((size) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Chip(
                      label: Text("$size"),
                      backgroundColor: Colors.white,
                      shape: StadiumBorder(
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  )),
            ],
          ),

          const SizedBox(height: 30),

          // Add to Cart Button (Corrected)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${widget.data['name']} added to cart!'),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text(
                  "Add to Cart",
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFC727),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper for color circle
  Widget _buildColorCircle(Color color, {bool selected = false}) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: selected
            ? Border.all(color: const Color(0xFFFFC727), width: 2)
            : null,
      ),
    );
  }
}
