import 'package:flutter/material.dart';
import 'package:flutter_exercise/daftarKode.dart';
import 'package:flutter_exercise/tabs/download.dart';
import 'package:flutter_exercise/tabs/first_tab.dart';
import 'package:flutter_exercise/tabs/glosarium.dart';
import 'package:flutter_exercise/tabs/komoditi.dart';
import 'package:flutter_exercise/tabs/wilayah.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    FirstTab(),
    Glosarium(),
    Komoditi(),
    DaftarKode(),
    Wilayah(),
    //Download(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        color: Colors.green.shade800,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 13),
          child: GNav(
            backgroundColor: Colors.green.shade800,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.green.shade600,
            padding: EdgeInsets.all(10),
            gap: 8,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Beranda',
              ),
              GButton(
                icon: Icons.menu_book_rounded,
                text: 'Glosarium',
              ),
              GButton(
                icon: Icons.density_small_rounded,
                text: 'Komoditas',
              ),
              GButton(
                icon: Icons.format_list_numbered,
                text: 'Daftar Kode',
              ),
              GButton(
                icon: Icons.map_sharp,
                text: 'Kode Wilayah',
              ),
              // GButton(
              //   icon: Icons.download,
              //   text: 'Download',
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
