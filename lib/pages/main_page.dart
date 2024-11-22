import 'package:flutter/material.dart';
import 'package:sprinter_mobile/pages/home_page.dart';
import 'package:sprinter_mobile/pages/profile_page.dart';
import 'package:sprinter_mobile/pages/saved_page.dart';
import 'package:sprinter_mobile/pages/search_page.dart';
import 'package:sprinter_mobile/pages/upload_page.dart';

class MainPage extends StatefulWidget {
  final int index;

  const MainPage({super.key, required this.index});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _currentIndex;

  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const UploadPage(),
    const SavedPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
        selectedItemColor: Theme.of(context).colorScheme.onSurface,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(
              Icons.search,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Upload',
            icon: Icon(Icons.upload),
          ),
          BottomNavigationBarItem(
            label: 'Saved',
            icon: Icon(Icons.file_download_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Me',
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
