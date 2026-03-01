import 'package:flutter/material.dart';
import 'package:nurulfalah_apps/extension/navigator.dart';
import 'package:nurulfalah_apps/pages/infaq_page.dart';
import 'package:nurulfalah_apps/pages/laporankegiatan_page.dart';
import 'package:nurulfalah_apps/pages/sedekahsubuh_page.dart';
import 'package:nurulfalah_apps/pages/zakat_page.dart';
import 'package:nurulfalah_apps/pages/zakat_penghasilan.dart';
import 'package:nurulfalah_apps/pages/zakatmaal_page.dart';

class MenuSection extends StatelessWidget {
  final List<Map<String, dynamic>> menu = [
    {"icon": Icons.mosque, "title": "Zakat"},
    {"icon": Icons.work, "title": "Zakat Penghasilan"},
    {"icon": Icons.account_balance_wallet, "title": "Zakat Maal"},
    {"icon": Icons.wb_sunny, "title": "Sedekah Subuh"},
    {"icon": Icons.favorite, "title": "Infaq"},
    {"icon": Icons.assignment, "title": "Laporan Kegiatan"},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: menu.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 0.9,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              switch (menu[index]["title"]) {
                case "Zakat":
                  context.push(ZakatPage());
                  break;

                case "Zakat Penghasilan":
                  context.push(ZakatPenghasilan());
                  break;

                case "Zakat Maal":
                  context.push(ZakatmaalPage());
                  break;

                case "Sedekah Subuh":
                  context.push(SedekahsubuhPage());
                  break;

                case "Infaq":
                  context.push(InfaqPage());
                  break;

                case "Laporan Kegiatan":
                  context.push(LaporankegiatanPage());
                  break;
              }
            },
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.green[50],
                  child: Icon(menu[index]["icon"], color: Colors.green),
                ),
                SizedBox(height: 8),
                Text(
                  menu[index]["title"],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
