import 'package:flutter/material.dart';
import 'package:nurulfalah_apps/pages/home_page.dart';
import 'package:nurulfalah_apps/pages/profil_page.dart';
import 'package:nurulfalah_apps/pages/riwayatdonasi_page.dart';
import 'package:nurulfalah_apps/pages/zakat_page.dart';
import 'package:nurulfalah_apps/pages_laporan%20CRUD/laporanadmin.dart';

class Bottomnavbar extends StatefulWidget {
  final String role;
  const Bottomnavbar({super.key, required this.role});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [HomePage(), RiwayatdonasiPage(), ProfilPage()];
    return Scaffold(
      body: pages[_selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.volunteer_activism),
            label: 'Donasi',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
