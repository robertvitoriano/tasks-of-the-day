import 'package:flutter/material.dart';
import 'package:flutter_todo/extensions/colors.dart';
import 'package:flutter_todo/presentation/pages/completed.dart';
import 'package:flutter_todo/presentation/pages/home.dart';
import 'package:flutter_todo/presentation/pages/profile.dart';

class Layout extends StatefulWidget {
  const Layout({super.key, required this.title});
  final String title;

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _currentIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(title: widget.title),
      const CompletedPage(),
      const ProfilePage(),
    ];
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
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_outline_outlined),
            label: 'Completed',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.amber[800],
      ),
      backgroundColor: "#E5FCEF".toColor(),
    );
  }
}
