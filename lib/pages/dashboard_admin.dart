import 'package:flutter/material.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F5F7),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// HEADER
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff1B5E20), Color(0xff2E7D32)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.mosque, color: Colors.amber, size: 40),

                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                child: Icon(Icons.person, size: 14),
                              ),
                              SizedBox(width: 6),
                              Text("Admin"),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    Text(
                      "Dashboard Admin",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "Masjid Nurul Falah",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              /// CARD STATISTIK
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    /// TOTAL DONASI
                    Expanded(
                      child: _statCard(
                        color: Colors.green,
                        title: "Total Donasi",
                        value: "Rp 125.800",
                        icon: Icons.wallet,
                      ),
                    ),

                    SizedBox(width: 10),

                    Expanded(
                      child: _statCard(
                        color: Colors.blue,
                        title: "Total Transaksi",
                        value: "248",
                        icon: Icons.receipt_long,
                      ),
                    ),

                    SizedBox(width: 10),

                    Expanded(
                      child: _statCard(
                        color: Colors.orange,
                        title: "Total Donatur",
                        value: "152",
                        icon: Icons.people,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              /// GRAFIK DONASI
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Grafik Donasi Per Bulan",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 20),

                    Container(
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/images/grafikdumy.png',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              /// FILTER
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Filter Laporan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text("Jenis Donasi"),

                    SizedBox(height: 6),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: "Semua",
                          items: [
                            DropdownMenuItem(
                              value: "Semua",
                              child: Text("Semua"),
                            ),
                          ],
                          onChanged: null,
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    Text("Bulan"),

                    SizedBox(height: 6),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: "Juni 2026",
                          items: [
                            DropdownMenuItem(
                              value: "Juni 2026",
                              child: Text("Juni 2026"),
                            ),
                          ],
                          onChanged: null,
                        ),
                      ),
                    ),

                    SizedBox(height: 14),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.search, color: Colors.white),
                        label: Text(
                          "Filter",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              /// RIWAYAT DONASI
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Riwayat Donasi Terbaru",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Lihat Semua",
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    _donasiItem("Infaq Jumat", "Rp 500.000", "12 Juni 2026"),
                    _donasiItem("Sedekah Subuh", "Rp 150.000", "11 Juni 2026"),
                  ],
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// CARD STATISTIK
  Widget _statCard({
    required Color color,
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      height: 90,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white),

          Spacer(),

          Text(title, style: TextStyle(color: Colors.white70, fontSize: 12)),

          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  /// ITEM RIWAYAT DONASI
  Widget _donasiItem(String jenis, String nominal, String tanggal) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(radius: 5, backgroundColor: Colors.green),
      title: Text(jenis),
      subtitle: Text(tanggal),
      trailing: Text(
        nominal,
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
      ),
    );
  }
}
