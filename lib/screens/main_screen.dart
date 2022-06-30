import 'package:flutter/material.dart';
import 'package:netflix/screens/screens.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List screens = const [
    HomeScreen(),
    UpcomingMoviesScreen(),
    Text('3'),
    DownloadsScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xff121212),
          unselectedItemColor: const Color(0x88ffffff),
          selectedFontSize: 10,
          iconSize: 20,
          unselectedFontSize: 10,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          onTap: _onNavItemSelect,
          items: [
            BottomNavigationBarItem(
                icon: Icon(_selectedIndex == 0
                    ? Icons.home_sharp
                    : Icons.home_outlined),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(_selectedIndex == 1
                    ? Icons.video_library_sharp
                    : Icons.video_library_outlined),
                label: 'Coming Soon'),
            BottomNavigationBarItem(
                icon: Icon(_selectedIndex == 2
                    ? Icons.mood_sharp
                    : Icons.mood_outlined),
                label: 'Fast Laughs'),
            BottomNavigationBarItem(
                icon: Icon(_selectedIndex == 3
                    ? Icons.download_sharp
                    : Icons.download_outlined),
                label: 'Downloads'),
          ]),
    );
  }

  _onNavItemSelect(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
