import 'package:flutter/material.dart';
import 'package:nurulfalah_apps/pages/dashboard_admin.dart';
import 'package:nurulfalah_apps/pages/home_page.dart';
import 'package:nurulfalah_apps/pages/profil_page.dart';
import 'package:nurulfalah_apps/pages_pembayaran/riwayatcrud.dart';

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
    /// HALAMAN UNTUK USER
    List<Widget> pagesUser = [HomePage(), Riwayatcrud(), ProfilPage()];

    /// HALAMAN UNTUK ADMIN
    List<Widget> pagesAdmin = [
      HomePage(),
      AdminDashboardPage(),
      Riwayatcrud(),
      ProfilPage(),
    ];

    /// PILIH PAGE BERDASARKAN ROLE
    final pages = widget.role == "admin" ? pagesAdmin : pagesUser;

    return Scaffold(
      body: pages[_selectIndex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,

        onTap: (index) {
          setState(() {
            _selectIndex = index;
          });
        },

        items: widget.role == "admin"
            ? const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.volunteer_activism),
                  label: 'Donasi',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ]
            : const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.volunteer_activism),
                  label: 'Donasi',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
      ),
    );
  }
}
