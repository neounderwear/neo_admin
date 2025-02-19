import 'package:flutter/material.dart';
import 'package:neo_admin/constant/widget/section_header.dart';
import 'package:neo_admin/features/product/data/product_table_model.dart';
import 'package:neo_admin/features/product/presentation/widget/product_table_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late TextEditingController searchController;
  late FocusNode searchFocusNode;

  List<ProductTableModel> products = [
    ProductTableModel(
      productName: 'Pierre Cardin',
      imageUrl:
          'https://images.unsplash.com/photo-1614850715649-1d0106293bd1?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      productPrice: '120000',
      productQty: '20',
      productOrdered: '120',
      productStatus: true,
    ),
    ProductTableModel(
      productName: 'Gucci Sneakers',
      imageUrl:
          'https://images.unsplash.com/photo-1614850715649-1d0106293bd1?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      productPrice: '120000',
      productQty: '20',
      productOrdered: '120',
      productStatus: true,
    ),
  ];

  @override
  void initState() {
    searchController = TextEditingController();
    searchFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(text: 'Produk'),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              // fillColor: Colors.grey[200],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        SizedBox(
                          height: 39.0,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.add),
                            label: const Text('Tambah Produk'),
                            onPressed: () {
                              // TODO: Tambahkan aksi tambah produk
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    ProductTableWidget(products: products),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
