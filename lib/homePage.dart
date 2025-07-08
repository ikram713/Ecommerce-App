import 'package:ecommerce_app/details.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;

  // Dynamic Categories List
  List<Map<String, dynamic>> categories = [
    {"icon": Icons.laptop, "label": "Laptop"},
    {"icon": Icons.watch, "label": "Watch"},
    {"icon": Icons.electric_bike_outlined, "label": "Bike"},
    {"icon": Icons.headphones, "label": "Headphones"},
    {"icon": Icons.watch, "label": "Watch"},
  ];

  List items = [
    {
      "image": "images/headphones.png",
      "name": "Headphones",
      "description": "Easy to use 3-10 hours",
      "price": "\$80.99"
    },
    {
      "image": "images/watch.png",
      "name": "Watch",
      "description": "Easy to use 3-10 hours",
      "price": "\$300.00"
    },
    {
      "image": "images/watch.png",
      "name": "Watch",
      "description": "Easy to use 3-10 hours",
      "price": "\$300.00"
    },
    {
      "image": "images/watch.png",
      "name": "Watch",
      "description": "Easy to use 3-10 hours",
      "price": "\$300.00"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // BottomNavigationBar with rounded corners and no splash effect
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
              selectedItemColor: Color.fromARGB(255, 210, 162, 16),
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

      // Page body
      body: SafeArea(
        child: _currentIndex == 0
            ? Container(
                padding: EdgeInsets.all(20),
                child: ListView(
                  children: [
                    // Search Bar
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search, color: Colors.grey),
                              hintText: "Search",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(Icons.menu, size: 40),
                        )
                      ],
                    ),
                    SizedBox(height: 30),

                    // Categories Title
                    Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),

                    // Categories List
                    Container(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.grey[200],
                                  ),
                                  height: 80,
                                  width: 80,
                                  padding: EdgeInsets.all(10),
                                  child: Icon(
                                    categories[index]["icon"],
                                    size: 45,
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
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 30),

                    // Best Selling Title
                    Text(
                      "Best Selling",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),

                    // Products Grid
                    GridView.builder(
                      itemCount: items.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        mainAxisExtent: 250,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ItemsDetails(data: items[index])));
                          },
                          child: Card(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    color: Colors.grey[200],
                                    width: double.infinity,
                                    child: Image.asset(
                                      items[index]["image"],
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  items[index]["name"],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  items[index]["description"],
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  items[index]["price"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 210, 162, 16),
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
