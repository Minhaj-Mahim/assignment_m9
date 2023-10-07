import 'package:flutter/material.dart';
void main() {
  runApp(ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShoppingCartScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  List<Item> cartItems = [
    Item(
        'Sweater', 'Purple', 'L', 51, 1,
        'https://images.pexels.com/photos/7653724/pexels-photo-7653724.jpeg?auto=compress&cs=tinysrgb&w=600'
    ),
    Item('T-Shirt', 'Black', 'L', 30, 1,
      'https://images.pexels.com/photos/1656684/pexels-photo-1656684.jpeg?auto=compress&cs=tinysrgb&w=600',
    ),
    Item('Wedding dress', 'White', 'M', 43, 1,
      'https://images.pexels.com/photos/4621963/pexels-photo-4621963.jpeg?auto=compress&cs=tinysrgb&w=600',
    ),
  ];

  double totalAmount() {
    double total = 0;
    for (int i=0; i<cartItems.length;i++) {
      total += cartItems[i].price * cartItems[i].quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        title: Text(
          'My Bag',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5.0,
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Container(
                width: 80.0,
                child: Image.network(
                  cartItems[index].imageUrl,
                  width: 60.0,
                  height: 60.0,
                  //fit: BoxFit.cover,
                ),
              ),
              title: Text(cartItems[index].name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Color: ${cartItems[index].color}  Size: ${cartItems[index].size}'),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (cartItems[index].quantity > 1) {
                              cartItems[index].quantity--;
                            }
                          });
                        },
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(cartItems[index].quantity.toString()),
                      SizedBox(
                        width: 5,
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            cartItems[index].quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Text(
                  '\$${(cartItems[index].price * cartItems[index].quantity).toStringAsFixed(2)}'),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Total Amount:'),
                  Spacer(),
                  Text("\$${totalAmount().toStringAsFixed(2)}"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Congratulations!, your order is placed!'),
                      ),
                    );
                  },
                  child: Text(
                    'CHECK OUT',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Item {
  final String name;
  final String color;
  final String size;
  final double price;
  int quantity;
  final String imageUrl;

  Item(this.name, this.color, this.size, this.price, this.quantity,
      this.imageUrl);
}