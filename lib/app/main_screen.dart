import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_admin/features/banner/presentation/ui/banner_screen.dart';
import 'package:neo_admin/features/brand/view/ui/brand_screen.dart';
import 'package:neo_admin/features/category/presentation/ui/category_screen.dart';
import 'package:neo_admin/features/customer/presentation/customer_screen.dart';
import 'package:neo_admin/features/dashboard/presentation/ui/dashboard_screen.dart';
import 'package:neo_admin/features/order/presentation/order_screen.dart';
import 'package:neo_admin/features/product/presentation/ui/product_screen.dart';
import 'admin_header.dart';
import 'admin_sidebar.dart';

class MainScreen extends StatelessWidget {
  final String name;
  const MainScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AdminHeader(),
      body: Row(
        children: [
          AdminSidebar(
            name: name,
            onItemTapped: (route) {
              context.go(route);
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildPage(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    switch (location) {
      case '/main/dashboard':
        return const DashboardScreen();
      case '/main/banner':
        return const BannerScreen();
      case '/main/category':
        return const CategoryScreen();
      case '/main/brand':
        return const BrandScreen();
      case '/main/product':
        return const ProductScreen();
      case '/main/order':
        return const OrderScreen();
      case '/main/customer':
        return const CustomerScreen();
      default:
        return const Center(child: Text('Page not found'));
    }
  }
}
