import 'package:flutter/material.dart';
import 'package:quanlygom/views/order/create_order_screen.dart';
import 'package:quanlygom/views/product/product_list_screen.dart';
import 'package:quanlygom/views/share_widgets/CurvedNavigationBar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [const ProductListScreen(), const OrderScreen()];
    return Scaffold(
      // extendBody: true,  ← xóa dòng này
      body: pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
