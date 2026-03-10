import 'package:flutter/material.dart';
import 'package:nurulfalah_apps/pages_pembayaran/qris_page.dart';

class PaymentPage extends StatefulWidget {
  final String jenis;
  final int nominal;

  const PaymentPage({super.key, required this.jenis, required this.nominal});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String formatRupiah(int number) {
    return "Rp ${number.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}";
  }

  bool sembunyikanNama = false;
  bool metodeQris = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pembayaran"), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 8),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "JENIS DONASI",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),

                              SizedBox(height: 4),

                              Text(
                                widget.jenis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),

                              SizedBox(height: 6),

                              Text(
                                formatRupiah(widget.nominal),
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        CircleAvatar(
                          backgroundColor: Colors.green.shade100,
                          child: Icon(
                            Icons.account_balance_wallet_outlined,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CheckboxListTile(
                      contentPadding:
                          EdgeInsets.zero, // penting supaya pas di container
                      value: sembunyikanNama,
                      onChanged: (value) {
                        setState(() {
                          sembunyikanNama = value!;
                        });
                      },
                      title: Text("Sembunyikan nama anda?"),
                      controlAffinity: ListTileControlAffinity.trailing,
                      activeColor: Colors.green,
                    ),
                  ),

                  SizedBox(height: 24),

                  Text(
                    "Metode Pembayaran",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 12),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CheckboxListTile(
                      contentPadding:
                          EdgeInsets.zero, // penting supaya pas di container
                      value: metodeQris,
                      onChanged: (value) {
                        setState(() {
                          metodeQris = value!;
                        });
                      },
                      secondary: Icon(Icons.qr_code),

                      title: Text("Qris"),
                      controlAffinity: ListTileControlAffinity.trailing,
                      activeColor: Colors.green,
                    ),
                  ),

                  SizedBox(height: 24),

                  /// DOA
                  Row(
                    children: [
                      Text(
                        "Doa & Dukungan",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 6),
                      Text("(Opsional)", style: TextStyle(color: Colors.grey)),
                    ],
                  ),

                  SizedBox(height: 12),

                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: TextField(
                      maxLines: 3,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText:
                            "Tuliskan doa atau harapan baik anda di sini...",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Pembayaran",
                      style: TextStyle(color: Colors.grey),
                    ),

                    Text(
                      formatRupiah(widget.nominal),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      /// pindah ke halaman QR
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QrisPage(
                            jenis: widget.jenis,
                            nominal: widget.nominal,
                          ),
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
                      "Bayar Sekarang ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  "Pembayaran aman & terenkripsi",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
