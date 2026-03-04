import 'package:flutter/material.dart';
import 'package:nurulfalah_apps/extension/navigator.dart';
import 'package:nurulfalah_apps/pages/infaqjumat_page.dart';
import 'package:nurulfalah_apps/pages/infaqumum_page.dart';

class InfaqPage extends StatelessWidget {
  const InfaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F3F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: Text(
          "Pilih Kategori Infaq",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),

      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            "Mau berinfaq apa\nhari ini?",
            style: TextStyle(
              color: Colors.lightGreen,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 6),

          Text(
            "Pilih kategori untuk mulai berbagi kebaikan.",
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),

          SizedBox(height: 20),

          // Infaq Jumat
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE8F7EE), Color(0xFFD4F3E0)],
                begin: AlignmentGeometry.topLeft, //Warna Gradient
                end: AlignmentGeometry.bottomRight, // Warna Gradient
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.mosque_rounded, color: Colors.green),
                    ),

                    Spacer(),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "KHUSUS HARI JUMAT",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12),

                Text(
                  "Infaq Jumat",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),

                SizedBox(height: 6),

                Text(
                  "Raih pahala berlipat ganda di hari yang mulia.\nSalurkan sedekah terbaikmu hari ini.",
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),

                SizedBox(height: 14),

                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      context.push(InfaqjumatPage());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Pilih", style: TextStyle(color: Colors.white)),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward, size: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 28),

          // Card Infaq Umum
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F3F5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.favorite, color: Colors.pinkAccent),
                ),

                SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Infaq Umum",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Sedekah kapan saja untuk \nkebaikan bersama.",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    context.push(infaqumum());
                  },
                  child: Icon(Icons.chevron_right, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
