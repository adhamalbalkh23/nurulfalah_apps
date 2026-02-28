import 'package:flutter/material.dart';
import 'package:nurulfalah_apps/widgets/header_section.dart';
import 'package:nurulfalah_apps/widgets/laporan_section.dart';
import 'package:nurulfalah_apps/widgets/menu_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderSection(),
            SizedBox(height: 58),
            MenuSection(),
            SizedBox(height: 24),
            LaporanSection(),
          ],
        ),
      ),
    );
  }
}
