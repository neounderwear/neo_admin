import 'package:flutter/material.dart';
import 'package:neo_admin/features/banner/presentation/banner_screen.dart';
import 'package:neo_admin/features/brand/presentation/brand_screen.dart';
import 'package:neo_admin/features/category/presentation/category_screen.dart';
import 'package:neo_admin/features/customer/presentation/customer_screen.dart';
import 'package:neo_admin/features/dashboard/presentation/dashboard_screen.dart';
import 'package:neo_admin/features/media/presentation/media_screen.dart';
import 'package:neo_admin/features/order/presentation/order_screen.dart';
import 'package:neo_admin/features/product/presentation/product_screen.dart';
import 'admin_header.dart';
import 'admin_sidebar.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main';

  final String name;
  const MainScreen({
    super.key,
    required this.name,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardScreen(),
    const MediaScreen(),
    const BannerScreen(),
    const CategoryScreen(),
    const BrandScreen(),
    const ProductScreen(),
    const OrderScreen(),
    const CustomerScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AdminHeader(),
      body: Row(
        children: [
          AdminSidebar(
            name: widget.name,
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }
}
