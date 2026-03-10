import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nurulfalah_apps/extension/navigator.dart';
import 'package:nurulfalah_apps/pages_pembayaran/payment_page.dart';

class SedekahsubuhPage extends StatefulWidget {
  const SedekahsubuhPage({super.key});

  @override
  State<SedekahsubuhPage> createState() => _SedekahsubuhPageState();
}

class _SedekahsubuhPageState extends State<SedekahsubuhPage> {
  final TextEditingController nominalController = TextEditingController();

  int selectedNominal = -1;

  final List<int> nominalList = [10000, 25000, 50000, 100000];

  final formatRupiah = NumberFormat("#,###", "id_ID");

  void setNominal(int value) {
    setState(() {
      selectedNominal = value;
      nominalController.text = formatRupiah.format(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F5F7),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: ListView(
            children: [
              SizedBox(height: 10),

              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // GAMBAR
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/images/sedekah-subuh.jpeg",
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(height: 20),

                  // Judul
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(text: "Awali pagimu dengan\n"),
                        TextSpan(
                          text: "kebaikan abadi.",
                          style: TextStyle(color: Colors.deepOrangeAccent),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  // Box Hadits
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFE8F5E9), Color(0xFFD0F0D6)],
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.wb_sunny,
                            color: Colors.deepOrangeAccent,
                          ),
                        ),

                        SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '"Tidak ada satu subuh pun yang dialami hamba-hamba Allah kecuali turun kepada mereka dua malaikat..."',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black87,
                                ),
                              ),

                              SizedBox(height: 8),

                              Text(
                                "— HR. Bukhari & Muslim",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.bolt, color: Colors.deepOrangeAccent),
                            SizedBox(width: 6),
                            Text(
                              "Sedekah Subuh",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                        SizedBox(height: 14),

                        Text(
                          "NOMINAL DONASI",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),

                        SizedBox(height: 6),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFFF1F2F4),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: TextField(
                            controller: nominalController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              RupiahInputFormatter(),
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Rp 0",
                            ),
                          ),
                        ),

                        SizedBox(height: 14),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: nominalList.map((nominal) {
                            bool selected =
                                nominalController.text ==
                                formatRupiah.format(nominal);

                            return GestureDetector(
                              onTap: () {
                                setNominal(nominal);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: selected
                                      ? Colors.green
                                      : Color(0xFFF1F2F4),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "${nominal ~/ 1000}k",
                                  style: TextStyle(
                                    color: selected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Center(
                    child: SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {});
                          context.push(
                            PaymentPage(
                              jenis: "Sedekah Subuh",
                              nominal: selectedNominal,
                            ),
                          );
                          if (nominalController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Masukkan nominal donasi'),
                              ),
                            );
                          } else {
                            // Implement donation logic
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Nominal berhasil di input'),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          "Sedekah Sekarang",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RupiahInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;

    String number = newValue.text.replaceAll('.', '');

    final formatter = NumberFormat("#,###", "id_ID");

    String newText = formatter.format(int.parse(number));

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
