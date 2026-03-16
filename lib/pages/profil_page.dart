import 'package:flutter/material.dart';
import 'package:nurulfalah_apps/database/prefernce.dart';
import 'package:nurulfalah_apps/extension/navigator.dart';
import 'package:nurulfalah_apps/pages/login_page.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  String nama = "";
  void loadUser() async {
    String? data = await PreferenceHandler.getNama();
    setState(() {
      nama = data ?? "user";
    });
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F5F7),

      appBar: AppBar(
        title: Text("Profil Saya"),
        backgroundColor: Color(0xfff90C67C),
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 10),

            // FOTO PROFIL
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(Icons.person, size: 50, color: Colors.grey),
                ),

                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Icon(Icons.check, color: Colors.white, size: 18),
                ),
              ],
            ),

            SizedBox(height: 12),

            Text(
              nama,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 30),

            // EDIT PROFIL
            Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green.withOpacity(0.1),
                    child: Icon(Icons.person_outline, color: Colors.green),
                  ),

                  SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      "Edit Profil",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),

                  Icon(Icons.chevron_right),
                ],
              ),
            ),

            // PUSAT BANTUAN
            Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green.withOpacity(0.1),
                    child: Icon(Icons.help_outline, color: Colors.green),
                  ),

                  SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      "Pusat Bantuan",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),

                  Icon(Icons.chevron_right),
                ],
              ),
            ),

            // LOGOUT
            InkWell(
              onTap: () {
                PreferenceHandler().deleteIsLogin();
                context.pushAndRemoveAll(Loginpage());
              },
              borderRadius: BorderRadius.circular(18),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.red.withOpacity(0.1),
                      child: Icon(Icons.logout, color: Colors.red),
                    ),

                    SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
