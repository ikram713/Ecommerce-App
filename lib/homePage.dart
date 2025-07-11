import 'package:ecommerce_app/details.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'item_search_delegate.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;
  int selectedIndex = -1;

  List<Map<String, dynamic>> categories = [
    {"icon": Icons.laptop, "label": "Laptop"},
    {"icon": Icons.watch, "label": "Watch"},
    {"icon": Icons.electric_bike_outlined, "label": "Bike"},
    {"icon": Icons.headphones, "label": "Headphones"},
    {"icon": Icons.phone_android, "label": "Phone"},
  ];

  List items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  void fetchItems() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.44.197.181:5000/api/items/items'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        setState(() {
          items = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        print('Failed to load items');
        setState(() => isLoading = false);
      }
    } catch (e) {
      print('Error: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: Material(
          color: Colors.white,
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              iconSize: 30,
              selectedItemColor: Color(0xFFFFC727),
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined), label: "*"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_bag_outlined), label: "*"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline), label: "*"),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: _currentIndex == 0
            ? SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar (FIXED)
                    GestureDetector(
                      onTap: () {
                        showSearch(context: context, delegate: ItemSearchDelegate());
                      },
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.grey),
                            SizedBox(width: 10),
                            Text(
                              "Search",
                              style: TextStyle(color: Colors.grey[600]),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),

                    // Categories
                    Text("Categories",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    Container(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          bool isSelected = selectedIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: isSelected
                                          ? const Color(0xFFFFC727)
                                          : Colors.grey[200],
                                    ),
                                    height: 80,
                                    width: 80,
                                    padding: EdgeInsets.all(10),
                                    child: Icon(
                                      categories[index]["icon"],
                                      size: 45,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    categories[index]["label"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[400],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 30),
                    Text("Best Selling",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),

                    isLoading
                        ? Center(child: CircularProgressIndicator())
                        : GridView.builder(
                            itemCount: items.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              mainAxisExtent: 250,
                            ),
                            itemBuilder: (context, index) {
                              final item = items[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ItemsDetails(data: item)));
                                },
                                child: Card(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          color: Colors.grey[200],
                                          width: double.infinity,
                                          child: Image.network(
                                            item["image"] ?? '',
                                            fit: BoxFit.contain,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Icon(Icons.broken_image),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        item["name"] ?? "No name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        item["description"] ??
                                            "No description",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Text(
                                        "\$${item["price"].toString()}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Color(0xFFFFC727),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              )
            : Center(
                child: Text(
                  _currentIndex == 1 ? "Cart Page" : "Profile Page",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
      ),
    );
  }
}
