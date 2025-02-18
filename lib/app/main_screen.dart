// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:neo_admin/features/banner/presentation/ui/banner_screen.dart';
import 'package:neo_admin/features/brand/presentation/ui/brand_screen.dart';
import 'package:neo_admin/features/category/presentation/ui/category_screen.dart';
import 'package:neo_admin/features/customer/presentation/customer_screen.dart';
import 'package:neo_admin/features/dashboard/presentation/ui/dashboard_screen.dart';
import 'package:neo_admin/features/order/presentation/order_screen.dart';
import 'package:neo_admin/features/product/presentation/ui/product_screen.dart';

import 'admin_header.dart';
import 'admin_sidebar.dart';

class MainScreen extends StatefulWidget {
  final Widget child;
  final String name;
  const MainScreen({
    super.key,
    required this.child,
    required this.name,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardScreen(),
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
