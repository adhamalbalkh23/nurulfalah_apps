import 'package:flutter/material.dart';
import 'package:nurulfalah_apps/extension/navigator.dart';
import 'package:nurulfalah_apps/pages/login_page.dart';

class Registerpage extends StatelessWidget {
  const Registerpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/images/Landing Page.png",
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 22, vertical: 62),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/logo app.png",
                        height: 316,
                        width: 316,
                      ),

                      Text(
                        "Pendaftaran Akun",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 2),

                Text(
                  "Nama",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Masukkan namamu disini",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  "Email",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Masukkan emailmu disini",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 4),

                Text(
                  "Password",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Masukkan passwordmu disini",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 4),

                Text(
                  "Konfirmasi Password",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Konfirmasi passwordmu disini",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            title: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 50,
                            ),
                            content: Text(
                              "Pendaftaran berhasil!",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Tutup popup
                                  context.pushReplacement(Loginpage());
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Daftar",
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
