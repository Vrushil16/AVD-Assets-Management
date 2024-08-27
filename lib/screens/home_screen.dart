import 'package:asset_mangement/screens/product_home_screen.dart';
import 'package:asset_mangement/screens/product_list_screen.dart';
import 'package:asset_mangement/utils/common_app_bar.dart';
import 'package:asset_mangement/utils/common_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: "Home",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomCard(
              icon: Icons.add_box,
              title: "Add New Product",
              color: Colors.orange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductFormScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            CustomCard(
              icon: Icons.view_list,
              title: "View Products",
              color: Colors.orange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductListScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
