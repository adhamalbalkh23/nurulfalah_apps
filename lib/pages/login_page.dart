import 'package:flutter/material.dart';
import 'package:nurulfalah_apps/bottomnavbar_global.dart';
import 'package:nurulfalah_apps/database/prefernce.dart';
import 'package:nurulfalah_apps/extension/navigator.dart';
import 'package:nurulfalah_apps/pages/register_page.dart';
import 'package:nurulfalah_apps/service/auth_service.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController emailContoler = TextEditingController();
  final TextEditingController passwordControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

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
            child: Form(
              key: _formKey,
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
                      ],
                    ),
                  ),

                  Text(
                    "Email",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: emailContoler,
                    decoration: InputDecoration(
                      hintText: "Masukan emailmu disini",
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email wajib diisi";
                      }
                      if (!value.contains("@")) {
                        return "Email harus mengandung @";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 16),
                  Text(
                    "Password",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: passwordControler,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Masukan passwordmu disini",
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password wajib diisi";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 24),

                  /// BUTTON LOGIN (SUDAH FIREBASE)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () async {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }

                              setState(() => isLoading = true);

                              try {
                                final user = await AuthService().login(
                                  email: emailContoler.text.trim(),
                                  password: passwordControler.text.trim(),
                                );

                                if (!mounted) return;

                                if (user != null) {
                                  // SIMPAN STATUS LOGIN
                                  await PreferenceHandler().storingIsLogin(
                                    true,
                                  );

                                  // SIMPAN ROLE
                                  print(
                                    "📝 Menyimpan role: '${user.role}' (Type: ${user.role.runtimeType})",
                                  );
                                  await PreferenceHandler().storingRole(
                                    user.role,
                                  );

                                  // SIMPAN NAMA
                                  await PreferenceHandler().storingNama(
                                    user.email,
                                  );

                                  // SIMPAN USER ID
                                  await PreferenceHandler().storingUserId(
                                    user.id,
                                  );

                                  String role = user.role;
                                  print(
                                    "👤 Role yang digunakan untuk navigasi: '$role'",
                                  );

                                  // DEBUG: Cetak semua users di Firestore
                                  await AuthService().debugPrintCurrentUser();

                                  if (user.role == "admin") {
                                    print("✅ Kondisi admin TRUE");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "✅ Login sebagai Pengurus Masjid",
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  } else {
                                    print(
                                      "❌ Kondisi admin FALSE (role='$role')",
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("✅ Login sebagai User"),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  }

                                  if (mounted) {
                                    context.pushAndRemoveAll(
                                      Bottomnavbar(role: role),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "❌ Email atau password salah",
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              } catch (e) {
                                if (mounted) {
                                  String errorMessage = "❌ Terjadi kesalahan";

                                  if (e.toString().contains("user-not-found")) {
                                    errorMessage = "❌ Email tidak terdaftar";
                                  } else if (e.toString().contains(
                                    "wrong-password",
                                  )) {
                                    errorMessage = "❌ Password salah";
                                  } else if (e.toString().contains(
                                    "invalid-email",
                                  )) {
                                    errorMessage = "❌ Email tidak valid";
                                  } else if (e.toString().contains(
                                    "user-disabled",
                                  )) {
                                    errorMessage = "❌ Akun telah dinonaktifkan";
                                  } else if (e.toString().contains(
                                    "too-many-requests",
                                  )) {
                                    errorMessage =
                                        "❌ Terlalu banyak percobaan, coba lagi nanti";
                                  } else if (e.toString().contains("network")) {
                                    errorMessage = "❌ Masalah koneksi internet";
                                  }

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(errorMessage),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              } finally {
                                if (mounted) {
                                  setState(() => isLoading = false);
                                }
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              "Masuk",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),

                  SizedBox(height: 20),

                  /// BUTTON KE REGISTER (TIDAK DIUBAH)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.push(Registerpage());
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
          ),
        ],
      ),
    );
  }
}
