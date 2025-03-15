import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_admin/constant/widget/section_header.dart';
import 'package:neo_admin/features/product/bloc/product_bloc.dart';
import 'package:neo_admin/features/product/bloc/product_event.dart';
import 'package:neo_admin/features/product/data/product_service.dart';
import 'package:neo_admin/features/product/view/ui/product_form_screen.dart';
import 'package:neo_admin/features/product/view/widget/product_table_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Halaman utama produk
class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final supabase = Supabase.instance.client;

  late TextEditingController searchController;
  late FocusNode searchFocusNode;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchFocusNode = FocusNode();
  }

  // Function to show the product form as a modal bottom sheet
  void _showProductForm({Map<String, dynamic>? product}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(ProductService(supabase)),
          child: ProductFormScreen(product: product),
        );
      },
    ).then((_) {
      // Refresh product list after modal is closed
      if (mounted) {
        context.read<ProductBloc>().add(LoadProducts());
      }
    });
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
                        // Show product form modal for adding a new product
                        _showProductForm();
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
                          const SizedBox(width: 12.0),
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      // Pass the _showProductForm callback to the product table
                      ProductTableWidget(
                        onEditProduct: (product) =>
                            _showProductForm(product: product),
                      ),
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
