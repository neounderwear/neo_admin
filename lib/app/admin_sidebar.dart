import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_admin/constant/widget/alert_dialog.dart';
import 'package:neo_admin/features/login/bloc/login_bloc.dart';
import 'package:neo_admin/features/login/bloc/login_event.dart';
import 'package:neo_admin/features/login/bloc/login_state.dart';

// SideBar atau NavigationBar
// sebagai navigasi antar halaman utama
// dalam aplikasi
class AdminSidebar extends StatelessWidget {
  final Function(String) _onItemTapped;

  const AdminSidebar(
      {super.key, required dynamic Function(String) onItemTapped})
      : _onItemTapped = onItemTapped;

  // List menu item untuk navigasi
  // halaman utama
  final List<Map<String, dynamic>> menuItems = const [
    {
      'title': 'Beranda',
      'icon': Icons.dashboard_rounded,
      'route': '/main/dashboard',
    },
    {
      'title': 'Banner',
      'icon': Icons.image_rounded,
      'route': '/main/banner',
    },
    {
      'title': 'Kategori',
      'icon': Icons.category_rounded,
      'route': '/main/category',
    },
    {
      'title': 'Merek',
      'icon': Icons.branding_watermark_rounded,
      'route': '/main/brand',
    },
    {
      'title': 'Produk',
      'icon': Icons.inventory_2_rounded,
      'route': '/main/product',
    },
    {
      'title': 'Pesanan',
      'icon': Icons.shopping_cart_rounded,
      'route': '/main/order',
    },
    {
      'title': 'Customer',
      'icon': Icons.people_rounded,
      'route': '/main/customer',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final String currentRoute = GoRouterState.of(context).uri.toString();
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          showDialog(
            context: context,
            builder: (context) => AlertDialogWarning(
                label: 'Kamu bisa masuk lagi nanti',
                function: () {
                  context.go('/login');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Berhasil logout',
                        style: TextStyle(color: Colors.white),
                      ),
                      duration: Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.green,
                      width: 300.0,
                    ),
                  );
                }),
          );
        }
      },
      child: Container(
        width: 250.0,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.0),
            Expanded(
              child: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  final isSelected = currentRoute == item['route'];

                  return ListTile(
                    leading: Icon(
                      item['icon'],
                      color: isSelected ? Colors.brown[600] : Colors.black45,
                    ),
                    title: Text(
                      item['title'],
                      style: TextStyle(
                        color: isSelected ? Colors.brown[600] : Colors.black45,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    selected: isSelected,
                    onTap: () => _onItemTapped(item['route']),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40.0),
                ),
                child: const Text(
                  'Keluar',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
                onPressed: () {
                  BlocProvider.of<LoginBloc>(context).add(LogoutRequested());
                },
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'Admin Gudang Pakaian Dalam v1.0.0',
                style: TextStyle(color: Colors.grey, fontSize: 12.0),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
