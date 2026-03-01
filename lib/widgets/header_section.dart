import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double headerHeight = screenHeight * 0.32;

    return SizedBox(
      height: headerHeight,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/headerapss.png",
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.5)),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SizedBox(height: 8),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 44,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 6),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.search, color: Colors.black54),
                              SizedBox(width: 8),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(width: 12),
                      Icon(
                        Icons.notification_add,
                        color: Colors.black,
                        size: 28,
                      ),
                    ],
                  ),

                  SizedBox(height: 134),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsetsDirectional.all(16),
                    margin: EdgeInsetsDirectional.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 8),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.mosque),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Assalamualaikum Adham",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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
