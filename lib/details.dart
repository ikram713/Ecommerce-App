import 'package:flutter/material.dart';

class ItemsDetails extends StatefulWidget {
  final dynamic data; // good practice to be explicit

  const ItemsDetails({super.key, required this.data}); // <-- pass data properly

  @override
  State<ItemsDetails> createState() => _ItemsDetailsState();
}

class _ItemsDetailsState extends State<ItemsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: EndDrawerButton(),
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart, size: 28, color: Colors.black),
            Text("Detail" , style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black
            )),
            Text("Mart" , style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 210, 162, 16)
            )),
          ],
        ),
        backgroundColor: Colors.grey[200],
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
          size: 28 
        ),

      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only( bottom: 20),
            color: Colors.grey[200],
            height: 400,
            child: Image.asset(widget.data['image'])
            ),
            Text(widget.data['name'], 
              style: TextStyle(
                fontSize: 22, 
                fontWeight: FontWeight.bold, 
                color: Colors.black
              ),
              textAlign: TextAlign.center,
            ),
            Container(height: 5,),
            Text(widget.data['description'], 
              style: TextStyle(
                fontSize: 16, 
                color: Colors.grey[700]
              ),
              textAlign: TextAlign.center,
            ),

              Container(height: 10,),
            Text(widget.data['price'], 
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFC727)
              ),
              textAlign: TextAlign.center,
            ),
              Container(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Color :"),
                SizedBox(width: 10,),
                Container(width: 20, height: 20, decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                  border: Border.all(
                  color: Color(0xFFFFC727), // <-- Change to any color you want
                  width: 2,             // <-- Border thickness
                  ),
                ),
                ),
                Text("  Grey", style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700]
                )
                ),
                SizedBox(width: 10,),
                    Container(width: 20, height: 20, decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                ),
                Text(" Black", style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700]
                )
                ),
            ],
            ),
            Container(height: 20,),
            Text("Size  :    38  39  40  41  42", 
              style: TextStyle(
                fontSize: 16, 
                color: Colors.grey[700]
              ),
              textAlign: TextAlign.center,
            ),
            Container(height: 40,),
            Align(
              child: SizedBox(
                width: 10,
                child: MaterialButton(
                  onPressed: () {
                    // Add your add to cart logic here
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${widget.data['name']} added to cart!')),
                    );
                  },
                  color: Color(0xFFFFC727),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
