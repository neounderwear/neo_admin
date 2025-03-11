import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_admin/constant/widget/form_label.dart';
import 'package:neo_admin/features/product/bloc/product_bloc.dart';
import 'package:neo_admin/features/product/bloc/product_state.dart';

// Solusi untuk ProductDropdownWidget:
class ProductDropdownWidget extends StatefulWidget {
  final int? selectedBrands;
  final int? selectedCategories;
  final Function(int?) onBrandChanged;
  final Function(int?) onCategoryChanged;

  const ProductDropdownWidget({
    super.key,
    this.selectedBrands,
    this.selectedCategories,
    required this.onBrandChanged,
    required this.onCategoryChanged,
  });

  @override
  State<ProductDropdownWidget> createState() => _ProductDropdownWidgetState();
}

class _ProductDropdownWidgetState extends State<ProductDropdownWidget> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProductBloc>(context);
    print('Current ProductBloc state: ${bloc.state.runtimeType}');
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Brand dropdown
            FormLabel(label: 'Merek'),
            const SizedBox(height: 8),
            _buildBrandDropdown(),

            const SizedBox(height: 16),

            // Category dropdown
            FormLabel(label: 'Kategori'),
            const SizedBox(height: 8),
            _buildCategoryDropdown(),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandDropdown() {
    return BlocConsumer<ProductBloc, ProductState>(
      listenWhen: (previous, current) => current is BrandsLoaded,
      listener: (context, state) {
        if (state is BrandsLoaded) {
          print('Brands listener called: ${state.brands.length} brands');
          // Print seluruh data brand untuk debug
          print(
              'Brand data detail: ${state.brands.map((b) => "${b['id']}: ${b['brand_name']}").join(", ")}');
        }
      },
      buildWhen: (previous, current) => current is BrandsLoaded,
      builder: (context, state) {
        if (state is BrandsLoaded) {
          final brands = state.brands;

          // Validasi nilai dropdown
          final isValidValue = widget.selectedBrands != null &&
              brands.any((brand) => brand['id'] == widget.selectedBrands);

          return DropdownButtonFormField<int>(
            value: isValidValue ? widget.selectedBrands : null,
            hint: const Text('Pilih Merek'),
            isExpanded: true,
            items: brands.map<DropdownMenuItem<int>>((brand) {
              // Coba akses nama dengan kemungkinan berbeda
              final brandName = brand['brand_name'] ?? // Coba key brand_name
                  brand['name'] ?? // Coba key name
                  'Merek #${brand['id']}'; // Fallback dengan ID

              return DropdownMenuItem<int>(
                value: brand['id'],
                child: Text(brandName),
              );
            }).toList(),
            onChanged: widget.onBrandChanged,
            validator: (value) => value == null ? 'Wajib dipilih' : null,
          );
        }

        // Fallback untuk state lain
        return DropdownButtonFormField<int>(
          hint: const Text('Memuat data merek...'),
          isExpanded: true,
          items: const [],
          onChanged: null,
        );
      },
    );
  }

  Widget _buildCategoryDropdown() {
    return BlocConsumer<ProductBloc, ProductState>(
      listenWhen: (previous, current) => current is CategoriesLoaded,
      listener: (context, state) {
        if (state is CategoriesLoaded) {
          print(
              'Categories listener called: ${state.categories.length} categories');
          print(
              'Category data detail: ${state.categories.map((c) => "${c['id']}: ${c['category_name'] ?? c['name']}").join(", ")}');
        }
      },
      buildWhen: (previous, current) => current is CategoriesLoaded,
      builder: (context, state) {
        if (state is CategoriesLoaded) {
          final categories = state.categories;

          // Validasi nilai dropdown
          final isValidValue = widget.selectedCategories != null &&
              categories.any(
                  (category) => category['id'] == widget.selectedCategories);

          return DropdownButtonFormField<int>(
            value: isValidValue ? widget.selectedCategories : null,
            hint: const Text('Pilih Kategori'),
            isExpanded: true,
            items: categories.map<DropdownMenuItem<int>>((category) {
              // Coba akses nama dengan kemungkinan berbeda
              final categoryName =
                  category['category_name'] ?? // Coba key category_name
                      category['name'] ?? // Coba key name
                      'Kategori #${category['id']}'; // Fallback dengan ID

              return DropdownMenuItem<int>(
                value: category['id'],
                child: Text(categoryName),
              );
            }).toList(),
            onChanged: widget.onCategoryChanged,
            validator: (value) => value == null ? 'Wajib dipilih' : null,
          );
        }

        // Fallback untuk state lain
        return DropdownButtonFormField<int>(
          hint: const Text('Memuat data kategori...'),
          isExpanded: true,
          items: const [],
          onChanged: null,
        );
      },
    );
  }
}
