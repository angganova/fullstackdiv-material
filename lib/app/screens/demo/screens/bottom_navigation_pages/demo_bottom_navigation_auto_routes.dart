// import 'package:flutter/material.dart';
// import 'package:fullstackdiv_material/app/components/bottom_navigation_bar/bottom_navigation_bar.dart';
// import 'package:fullstackdiv_material/app/components/bottom_navigation_bar/bottom_navigation_item.dart';
// import 'package:fullstackdiv_material/app/components/header/basic_header.dart';
//
// class BottomNavigationAutoRoute extends StatefulWidget {
//   @override
//   _MainPageState createState() => _MainPageState();
// }
//
// class _MainPageState extends State<BottomNavigationAutoRoute> {
//   /// this is where we apply the Floating [BottomNavigationBar]
//   /// and as for the pages navigation, we use [auto_route]
//
//   /// This navigator state will be used to navigate different pages
//   final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
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
//       title: 'Saved',
//       route: Routes.demoSavedPage,
//     ),
//     CustomBottomNavigationItem(
//       icon: Icons.brightness_2_outlined,
//       title: 'Profile',
//       route: Routes.demoProfilePage,
//     ),
//   ];
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
//                   Navigator(
//                     key: _navigatorKey,
//                     onGenerateRoute: AppRouter(),
//                     initialRoute: navBarItems[_currentIndex].route,
//                   ),
//                   CustomBottomNavigationBar(
//                     onTap: (int index) {
//                       ///returns tab id which is user tapped
//                       setState(() {
//                         _currentIndex = index;
//                       });
//
//                       /// navigate to the child page
//                       _navigatorKey.currentState
//                           .pushReplacementNamed(navBarItems[index].route);
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
