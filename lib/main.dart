// import 'dart:collection';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

import 'package:ai_reviewhub/constant/dummy.dart';
import 'package:ai_reviewhub/view/component/category_row.dart';
import 'package:ai_reviewhub/view/component/header_widget.dart';
import 'package:ai_reviewhub/view/component/related_keyword.dart';
import 'package:ai_reviewhub/view/product_detail';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AiReviewHub',
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const Dashboard()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo.png', // Path to the local image
              width: 200, // Adjust the size as needed
              height: 200, // Adjust the size as needed
              fit: BoxFit.contain, // Adjust how the image fits into the widget
            ),
            const SizedBox(height: 20),
            const Text("AiReviewHub",
                style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            CircularProgressIndicator(
                color: Colors.blue), // Optional progress indicator
          ],
        ),
      ),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  int selectedIndex = -1;
  int selectedSideBarCategory = -1;
  String selectedSubcategory = '';
  bool isExtraFeatures = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 233, 187, 118),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderWidget(size: size),
                categoryWidget(size, categoryList),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        filterSidebarWidget(sideBarCategoryList),
                        Expanded(
                          flex: 6,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 125, 117, 213),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                RelatedKeyword(relatedKeyword: relatedKeyword),
                                productCard(),

                                // Add this line for the footer
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const FooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded productCard() {
    return Expanded(
      child: GridView.builder(
        primary: false,
        shrinkWrap: false,
        itemCount: productList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailsPage(product: productList[index]),
                ),
              );
            },
            child: Container(
              height: 110,
              width: 50,
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 218, 207, 223),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 46, 50, 60).withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(productList[index]['image']),
                        height: 170,
                      ),
                    ],
                  ),
                  Text(
                    productList[index]['title'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    productList[index]['price'],
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                          initialRating: productList[index]['rating'],
                          minRating: 1,
                          itemSize: 12,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            // Optionally handle rating update
                            // This example does not update the productList to save the new rating
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            productList[index]['favorite']
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              productList[index]['favorite'] =
                                  !productList[index]['favorite'];
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.link),
                          onPressed: () async {
                            var url = productList[index]['url'];
                            if (await canLaunch(url)) {
                              await launch(url, forceSafariVC: false);
                            } else {
                              // Optionally, add some user feedback that the URL couldn't be opened.
                              print('Could not launch $url');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

// Yaha Tak Hai
//
//
  Expanded filterSidebarWidget(List<Map<String, dynamic>> sideBarCategoryList) {
    return Expanded(
      flex: 2,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 56,
              width: 300,
              child: TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Color.fromARGB(255, 74, 121, 197),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/icons/svg/filter-variant.svg'),
                    const Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Category',
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 250,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: List.generate(
                  sideBarCategoryList.length,
                  (index) => CategorySideBarRow(
                    title: sideBarCategoryList[index]['title'],
                    caption: sideBarCategoryList[index]['subtitle'],
                    subCategory: sideBarCategoryList[index]['sub_category'],
                    isSelected: selectedSideBarCategory == index,
                    index: index,
                    selectedIndex: selectedSideBarCategory,
                    selectedSubcategory: selectedSubcategory,
                    subCategoryOntap: (String value) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        selectedSubcategory = value;
                        setState(() {});
                      });
                    },
                    onTap: () {
                      selectedSideBarCategory = index;
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 600),
              curve: Curves.ease,
              child: Container(
                height: isExtraFeatures ? null : 45,
                margin: const EdgeInsets.only(right: 30),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 213, 213, 233),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        isExtraFeatures = !isExtraFeatures;
                        setState(() {});
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(
                          top: 15,
                          left: 10,
                          right: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Extra Filters',
                            ),
                            RotatedBox(
                              quarterTurns: isExtraFeatures ? 25 : 0,
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isExtraFeatures)
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: List.generate(
                            extraFilter.length,
                            (index) => Row(
                              children: [
                                Checkbox(
                                  value: extraFilter[index]['is_selected'],
                                  onChanged: (e) {
                                    extraFilter[index]['is_selected'] =
                                        !extraFilter[index]['is_selected'];
                                    setState(() {});
                                  },
                                ),
                                Text(extraFilter[index]['title'])
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Padding categoryWidget(Size size, List<Map<String, dynamic>> categoryList) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: SizedBox(
        height: 56,
        width: size.width - size.width * 0.05,
        child: ListView.builder(
          itemCount: categoryList.length,
          scrollDirection: Axis.horizontal,
          physics: const ScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                selectedIndex = index;
                setState(() {});
              },
              child: Container(
                width: 144,
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? const Color.fromARGB(255, 0, 0, 0)
                      : const Color.fromARGB(255, 136, 11, 182),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      categoryList[index]['icon'],
                      color: selectedIndex == index
                          ? const Color.fromARGB(255, 2, 68, 12)
                          : const Color.fromARGB(255, 8, 0, 0),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      categoryList[index]['title'],
                      style: const TextStyle(
                        color: Color.fromARGB(255, 133, 139, 150),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: const Text('Home'),
//     ),
//     body: const SingleChildScrollView(
//       child: Column(
//         children: <Widget>[
//           // Your other widgets or contents can go here
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Text(
//               'Welcome to the Dashboard!',
//               style: TextStyle(fontSize: 20),
//             ),
//           ),
//           FooterWidget(), // Include the footer widget at the end
//         ],
//       ),
//     ),
//   );
// }

// class FooterWidget extends StatefulWidget {
//   const FooterWidget({Key? key}) : super(key: key);

//   @override
//   _FooterWidgetState createState() => _FooterWidgetState();
// }

// class _FooterWidgetState extends State<FooterWidget> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _feedbackController = TextEditingController();

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _feedbackController.dispose();
//     super.dispose();
//   }

//   void _submitFeedback() {
//     // Handle the form submission here
//     print('Name: ${_nameController.text}');
//     print('Email: ${_emailController.text}');
//     print('Feedback: ${_feedbackController.text}');

//     // Clear the form fields
//     _nameController.clear();
//     _emailController.clear();
//     _feedbackController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           const Text(
//             'About Our Website',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),
//           const Text(
//             'This is a demo website for showcasing Flutter development.',
//             style: TextStyle(fontSize: 14),
//           ),
//           const SizedBox(height: 20),
//           TextField(
//             controller: _nameController,
//             decoration: const InputDecoration(
//               labelText: 'Your Name',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 10),
//           TextField(
//             controller: _emailController,
//             decoration: const InputDecoration(
//               labelText: 'Your Email',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 10),
//           TextField(
//             controller: _feedbackController,
//             decoration: const InputDecoration(
//               labelText: 'Your Feedback',
//               border: OutlineInputBorder(),
//             ),
//             maxLines: 3,
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: _submitFeedback,
//             child: const Text('Submit Feedback'),
//           ),
//         ],
//       ),
//     );
//   }
// }
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: const Text('Home'),
//     ),
//     body: LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//         return SingleChildScrollView(
//           child: ConstrainedBox(
//             constraints: BoxConstraints(
//               minHeight: constraints.maxHeight,
//             ),
//             child: IntrinsicHeight(
//               child: Column(
//                 children: <Widget>[
//                   const Padding(
//                     padding: EdgeInsets.all(16.0),
//                     child: Text(
//                       'Welcome to the Dashboard!',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                   ),
//                   // Expanded or flexible space to fill the screen
//                   Expanded(
//                     child: Container(),
//                   ),
//                   const FooterWidget(), // Footer widget at the end
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     ),
//   );
// }

// Additional Footer Widget definition
class FooterWidget extends StatefulWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  _FooterWidgetState createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
  bool _isWidgetVisible = true; // Initially, the whole widget is visible

  @override
  Widget build(BuildContext context) {
    if (!_isWidgetVisible) {
      return SizedBox
          .shrink(); // Return an empty container if visibility is false
    }

    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      color: Colors.blueGrey[200],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'About Our Website',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'An "AI Review Hub" is a digital platform or website designed to serve as a central resource for reviews, information, and discussions related to artificial intelligence (AI) technologies, tools, software, and services. The primary goal of an AI Review Hub is to provide valuable insights and guidance to individuals and businesses interested in leveraging AI for various purposes',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 5),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isWidgetVisible =
                    false; // Hide the entire widget on button press
              });
            },
            child: const Text('ok'),
          ),
        ],
      ),
    );
  }
}
