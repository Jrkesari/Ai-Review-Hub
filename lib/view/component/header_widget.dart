import 'package:flutter/material.dart';
import 'sign_in_page.dart';
import 'package:ai_reviewhub/view/product_detail'; // Make sure this page exists and is set up properly
import 'package:ai_reviewhub/constant/dummy.dart';

class HeaderWidget extends StatefulWidget {
  final Size size;
  HeaderWidget({Key? key, required this.size}) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  bool isLoggedIn = false; // State to track login status
  TextEditingController searchController = TextEditingController();

  void toggleLoginState() {
    setState(() {
      isLoggedIn = !isLoggedIn;
    });
  }

  void performSearch(String query) {
    var product = productList.firstWhere(
      (product) => product['title'].toLowerCase().contains(query.toLowerCase()),
      orElse: () => <String, dynamic>{}, // Return an empty map instead of null
    );

    if (product.isNotEmpty) {
      // Logic to handle found product
      print("Ai tool found: ${product['title']}");
    } else {
      // Logic to handle no product found
      print("No Tool found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0066CC),
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side of the header, potentially with the logo and other elements
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Image(
                  image: AssetImage('assets/logo.png'),
                  height: 30,
                ),
              ),
              SizedBox(width: 26),
            ],
          ),
          // Middle element, possibly for searching
          Expanded(
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon:
                      const Icon(Icons.search, color: Colors.deepPurple),
                  border: InputBorder.none,
                  hintText: "Search for products...",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close, size: 17, color: Colors.red),
                    onPressed: () => searchController.clear(),
                  ),
                ),
                onSubmitted: (text) => performSearch(text),
              ),
            ),
          ),
          // Right side of the header, changing dynamically based on login status
          TextButton(
            onPressed: () {
              if (isLoggedIn) {
                toggleLoginState(); // Log out
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => SignInPage(
                              onSignedIn: toggleLoginState,
                            )));
              }
            },
            child: Text(
              isLoggedIn ? 'Sign Out' : 'Sign In',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
