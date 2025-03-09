import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'admin_header.dart';
import 'admin_sidebar.dart';

// Halaman utama sebagai root
// dari halaman aplikasi
class MainLayout extends StatelessWidget {
  final String currentRoute;
  final Widget child;

  const MainLayout({
    Key? key,
    required this.currentRoute,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AdminHeader(),
      body: Row(
        children: [
          AdminSidebar(
            onItemTapped: (route) => context.go(route),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
