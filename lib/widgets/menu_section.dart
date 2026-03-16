import 'package:flutter/material.dart';
import 'package:nurulfalah_apps/database/prefernce.dart';
import 'package:nurulfalah_apps/extension/navigator.dart';
import 'package:nurulfalah_apps/pages/infaq_page.dart';
import 'package:nurulfalah_apps/pages/sedekahsubuh_page.dart';
import 'package:nurulfalah_apps/pages/zakat_page.dart';
import 'package:nurulfalah_apps/pages_laporan%20CRUD/laporanadmin.dart';

class MenuSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 0.9,
        ),
        children: [
          // Zakat
          InkWell(
            onTap: () => context.push(ZakatPage()),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.green[50],
                  child: Icon(
                    Icons.volunteer_activism,
                    color: Colors.lightBlueAccent,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Zakat",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Sedekah Subuh
          InkWell(
            onTap: () => context.push(SedekahsubuhPage()),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.green[50],
                  child: Icon(Icons.wb_sunny, color: Colors.orangeAccent),
                ),
                SizedBox(height: 8),
                Text(
                  "Sedekah Subuh",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Infaq
          InkWell(
            onTap: () => context.push(InfaqPage()),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.green[50],
                  child: Icon(Icons.favorite, color: Colors.redAccent),
                ),
                SizedBox(height: 8),
                Text(
                  "Infaq",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Zakat Maal
          InkWell(
            onTap: () => context.push(ZakatPage()),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.green[50],
                  child: Icon(Icons.account_balance, color: Colors.pinkAccent),
                ),
                SizedBox(height: 8),
                Text(
                  "Zakat Maal",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Zakat Penghasilan
          InkWell(
            onTap: () => context.push(ZakatPage()),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.green[50],
                  child: Icon(Icons.work, color: Colors.deepPurpleAccent),
                ),
                SizedBox(height: 8),
                Text(
                  "Zakat \nPenghasilan",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Laporan
          InkWell(
            onTap: () async {
              String? role = await PreferenceHandler.getRole();
              if (!context.mounted) return;
              if (role == "admin") {
                context.push(Laporanadmin());
              } else {
                context.push(Laporanadmin());
              }
            },
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.green[50],
                  child: Icon(Icons.assignment_add, color: Colors.lightGreen),
                ),
                SizedBox(height: 8),
                Text(
                  "Laporan \n Kegiatan",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
