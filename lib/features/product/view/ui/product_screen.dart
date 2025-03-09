import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_admin/constant/widget/section_header.dart';
import 'package:neo_admin/features/product/view/widget/product_table_widget.dart';

// Halaman utama produk
class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late TextEditingController searchController;
  late FocusNode searchFocusNode;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SectionHeader(text: 'Produk'),
                  SizedBox(
                    height: 39.0,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text('Tambah Produk'),
                      onPressed: () {
                        context.go('/tambah-produk');
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 24.0,
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 500.0,
                            child: TextField(
                              controller: searchController,
                              focusNode: searchFocusNode,
                              decoration: InputDecoration(
                                hintText: 'Cari produk...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                prefixIcon: const Icon(Icons.search),
                                filled: true,
                              ),
                            ),
                          ),
                          // fillColor: Colors.grey[200]
                          const SizedBox(width: 12.0),
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      ProductTableWidget(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }
}
