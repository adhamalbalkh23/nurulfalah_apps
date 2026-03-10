import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nurulfalah_apps/extension/navigator.dart';
import 'package:nurulfalah_apps/pages_pembayaran/payment_page.dart';

class infaqumum extends StatefulWidget {
  infaqumum({super.key});

  @override
  State<infaqumum> createState() => _InfaqUmumState();
}

class _InfaqUmumState extends State<infaqumum> {
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

              SizedBox(height: 20),

              Text(
                "Infaq",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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
                        Icon(Icons.bolt, color: Colors.green),
                        SizedBox(width: 6),
                        Text(
                          "Infaq Cepat",
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
                                color: selected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              Text(
                "Pilih Jenis Infaq",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.favorite, color: Colors.blue),
                          SizedBox(height: 8),
                          Text(
                            "Infaq Umum",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: 10),

                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.mosque_rounded, color: Colors.green),
                          SizedBox(height: 8),
                          Text(
                            "Infaq Jumat",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24),

              SizedBox(
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {});
                    context.push(
                      PaymentPage(
                        jenis: "Infaq Umum",
                        nominal: selectedNominal,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Infaq Sekarang",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
