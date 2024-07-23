import 'package:airbnb_clone/presentation/guest/screens/explore_screen.dart';
import 'package:airbnb_clone/presentation/guest/screens/inbox_screen.dart';
import 'package:airbnb_clone/presentation/guest/screens/saved_listings_screen.dart';
import 'package:airbnb_clone/presentation/guest/screens/trips_screen.dart';
import 'package:airbnb_clone/presentation/guest/widgets/custom_container.dart';
import 'package:airbnb_clone/presentation/profile/screen/profile_screen.dart';
import 'package:airbnb_clone/utils/styles_class.dart';
import 'package:flutter/material.dart';

class GuestHomeScreen extends StatefulWidget {
  const GuestHomeScreen({super.key});

  @override
  State<GuestHomeScreen> createState() => _GuestHomeScreenState();
}

class _GuestHomeScreenState extends State<GuestHomeScreen> {
  List<Widget> screens = [
    const ExploreScreen(),
    const SavedListingsScreen(),
    const TripsScreen(),
    const InboxScreen(),
    const ProfileScreen()
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const CustomContainer(),
        title: Text(Styles.screenTitles[index]),
        automaticallyImplyLeading: false,
      ),
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        selectedItemColor: Styles.primaryColor,
        onTap: (i) {
          setState(() {
            index = i;
          });
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: Styles.screenTitles[0],
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.favorite_border),
              label: Styles.screenTitles[1]),
          BottomNavigationBarItem(
              icon: const Icon(Icons.hotel), label: Styles.screenTitles[2]),
          BottomNavigationBarItem(
              icon: const Icon(Icons.message), label: Styles.screenTitles[3]),
          BottomNavigationBarItem(
              icon: const Icon(Icons.person), label: Styles.screenTitles[4]),
        ],
      ),
    );
  }
}
