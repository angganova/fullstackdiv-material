// import 'package:flutter/material.dart';
// import 'package:fullstackdiv_material/app/components/bottom_navigation_bar/bottom_navigation_bar.dart';
// import 'package:fullstackdiv_material/app/components/bottom_navigation_bar/bottom_navigation_item.dart';
// import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
//
// import 'test_discover_page.dart';
// import 'test_profile_page.dart';
// import 'test_saved_page.dart';
// import 'test_travel_page.dart';
//
// class BottomNavigationPageController extends StatefulWidget {
//   @override
//   _MainPageState createState() => _MainPageState();
// }
//
// class _MainPageState extends State<BottomNavigationPageController> {
//   /// this is where we apply the Floating [BottomNavigationBar]
//   /// and as for the pages navigation, we use [PageController]
//
//   int _currentIndex = 0;
//
//   /// this is the list of the navigation bar items
//   final List<CustomBottomNavigationItem> navBarItems =
//       <CustomBottomNavigationItem>[
//     CustomBottomNavigationItem(
//       icon: Icons.brightness_1_outlined,
//       title: 'Travel',
//       route: Routes.demoTravelPage,
//     ),
//     CustomBottomNavigationItem(
//       icon: Icons.brightness_2,
//       title: 'Discover',
//       route: Routes.demoDiscoverPage,
//     ),
//     CustomBottomNavigationItem(
//       icon: Icons.brightness_1_rounded,
//       title: 'Profile',
//       route: Routes.demoProfilePage,
//     ),
//   ];
//
//   /// this is the list of the [PageView] controllers
//   final List<Widget> childPages = <Widget>[
//     DemoTravelPage(),
//     DemoDiscoverPage(),
//     DemoSavedPage(),
//     DemoProfilePage(),
//   ];
//
//   /// this is the page controller
//   PageController _pageController;
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: <Widget>[
//             BasicHeader(
//               title: navBarItems[_currentIndex].title,
//               onBackButtonTapped: () {
//                 Navigator.pop(context);
//               },
//             ),
//             Expanded(
//               child: Stack(
//                 children: <Widget>[
//                   PageView(
//                     controller: _pageController,
//                     children: childPages,
//                     onPageChanged: (int page) {
//                       setState(() {
//                         _currentIndex = page;
//                       });
//                     },
//                     physics: const NeverScrollableScrollPhysics(),
//                   ),
//                   CustomBottomNavigationBar(
//                     onTap: (int index) {
//                       ///returns tab id which is user tapped
//                       setState(() {
//                         _currentIndex = index;
//                       });
//
//                       /// the reason why we use [jumpToPage] in here
//                       /// is because if we use [animateToPage]
//                       /// the navigation will have a weird behavior
//                       /// when jumping from for example 0 to 2 or 3 to 1
//                       /// you can uncomment this if you want to try :
//                       /// pageController.animateToPage(index, duration: kDuration100, curve: Curves.easeIn);
//
//                       _pageController.jumpToPage(index);
//                     },
//                     currentIndex: _currentIndex,
//                     items: navBarItems,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
