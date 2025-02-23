import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_admin/constant/widget/section_header.dart';
import 'package:neo_admin/features/category/bloc/category_bloc.dart';
import 'package:neo_admin/features/category/bloc/category_event.dart';
import 'package:neo_admin/features/category/bloc/category_state.dart';
import 'package:neo_admin/features/category/view/widget/category_form_widget.dart';
import 'package:neo_admin/features/category/view/widget/category_table_widget.dart';

// Halaman utama kategori produk
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(LoadCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                          builder: (context) => CategoryFormWidget(),
                        );
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24.0),
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  return Container(
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
                      child: CategoryTableWidget(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
