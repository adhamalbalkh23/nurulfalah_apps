import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfaqjumatPage extends StatefulWidget {
  InfaqjumatPage({super.key});

  @override
  State<InfaqjumatPage> createState() => _InfaqjumatPageState();
}

class _InfaqjumatPageState extends State<InfaqjumatPage> {
  int selectedIndex = 0;

  final List<int> nominal = [10000, 50000, 100000];
  final TextEditingController nominalController = TextEditingController();
  final formatRupiah = NumberFormat("#,###", "id_ID");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: ListView(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: Image.asset(
                  "assets/images/infaq_jumat.png",
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black54],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),

              SafeArea(
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),

              Positioned(
                bottom: 24,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Keutamaan Hari Jumat",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      "Raih pahala berlipat di hari yang mulia.",
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          // INFO EDUKASI
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.circle, size: 10, color: Colors.green),
                SizedBox(width: 6),
                Text(
                  "Info Edukasi",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.book, color: Colors.grey),
                      SizedBox(width: 10),
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
                              "Dilakukan kapan saja untuk keberkahan harian dan penyucian harta.",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 14),

                  Row(
                    children: [
                      Icon(Icons.info, color: Colors.orange),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Infaq Jumat",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Memanfaatkan kemuliaan hari Jumat yang pahalanya dilipatgandakan.",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),

          // PILIH NOMINAL
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Pilih Nominal Infaq",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          SizedBox(height: 12),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ...List.generate(nominal.length, (index) {
                  bool selected = selectedIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      width: 150,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: selected
                            ? Colors.green.withValues(alpha: 0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: selected ? Colors.green : Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        "Rp ${nominal[index]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }),

                // KOTAK INPUT NOMINAL
                Container(
                  width: 150,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Nominal Lain",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      TextField(
                        controller: nominalController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Input...",
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 30),

          // TOTAL + BUTTON
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total Donasi"),
                    Text(
                      nominalController.text.isEmpty
                          ? "Rp ${formatRupiah.format(nominal[selectedIndex])}"
                          : "Rp ${nominalController.text}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                SizedBox(height: 14),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Infaq Sekarang ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
