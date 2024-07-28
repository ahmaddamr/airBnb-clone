import 'package:airbnb_clone/presentation/guest/screens/inbox_screen.dart';
import 'package:airbnb_clone/presentation/guest/widgets/custom_container.dart';
import 'package:airbnb_clone/presentation/host/screens/booking_screen.dart';
import 'package:airbnb_clone/presentation/host/screens/my_postings_screen.dart';
import 'package:airbnb_clone/presentation/profile/screen/profile_screen.dart';
import 'package:airbnb_clone/utils/styles_class.dart';
import 'package:flutter/material.dart';

class HostScreen extends StatefulWidget {
  const HostScreen({super.key});

  @override
  State<HostScreen> createState() => _HostScreenState();
}

class _HostScreenState extends State<HostScreen> {
  List<Widget> screens = [
    const BookingScreen(),
    const MyPostingsScreen(),
    const InboxScreen(),
      ProfileScreen()
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace:  CustomContainer(),
        title: Text(Styles.hostTitles[index]),
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
            icon: const Icon(Icons.calendar_today),
            label: Styles.hostTitles[0],
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: Styles.hostTitles[1]),
          // BottomNavigationBarItem(
          //     icon: const Icon(Icons.hotel), label: Styles.hostTitles[2]),
          BottomNavigationBarItem(
              icon: const Icon(Icons.message), label: Styles.hostTitles[2]),
          BottomNavigationBarItem(
              icon: const Icon(Icons.person), label: Styles.hostTitles[3]),
        ],
      ),
    );
  }
}
