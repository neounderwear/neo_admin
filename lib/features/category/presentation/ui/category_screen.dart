import 'package:flutter/material.dart';
import 'package:neo_admin/constant/widget/section_header.dart';
import 'package:neo_admin/features/category/presentation/widget/add_category_widget.dart';
import 'package:neo_admin/features/category/presentation/widget/category_table_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SectionHeader(text: 'Kategori'),
                SizedBox(
                  height: 39.0,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(),
                    icon: const Icon(Icons.add),
                    label: const Text('Tambah Baru'),
                    onPressed: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => AddCategoryWidget(),
                      );
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 24.0),
            CategoryTableWidget(),
          ],
        ),
      ),
    );
  }
}
