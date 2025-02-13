import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminSidebar extends StatelessWidget {
  final String name;
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const AdminSidebar({
    super.key,
    required this.name,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  final List<Map<String, dynamic>> menuItems = const [
    {'title': 'Beranda', 'icon': Icons.dashboard_rounded},
    {'title': 'Banner', 'icon': Icons.image_rounded},
    {'title': 'Kategori', 'icon': Icons.category_rounded},
    {'title': 'Merek', 'icon': Icons.branding_watermark_rounded},
    {'title': 'Produk', 'icon': Icons.inventory_2_rounded},
    {'title': 'Pesanan', 'icon': Icons.shopping_cart_rounded},
    {'title': 'Customer', 'icon': Icons.people_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                'Halo, $name',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                final isSelected = selectedIndex == index;

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
                  onTap: () => onItemTapped(index),
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
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Mau kemana?'),
                      content: const Text('Kamu bisa masuk lagi nanti'),
                      actions: [
                        TextButton(
                          child: const Text('Batal'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text(
                            'Keluar',
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () => context.go('/login'),
                        ),
                      ],
                    );
                  },
                );
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
    );
  }
}
