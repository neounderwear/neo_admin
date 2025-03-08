import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_admin/constant/widget/form_label.dart';
import 'package:neo_admin/features/product/bloc/product_bloc.dart';

class ProductDropdownWidget extends StatefulWidget {
  final int? selectedBrands;
  final int? selectedCategories;
  final Function(int?)? onBrandChanged;
  final Function(int?)? onCategoryChanged;

  const ProductDropdownWidget({
    super.key,
    this.selectedBrands,
    this.selectedCategories,
    this.onBrandChanged,
    this.onCategoryChanged,
  });

  @override
  State<ProductDropdownWidget> createState() => _ProductDropdownWidgetState();
}

class _ProductDropdownWidgetState extends State<ProductDropdownWidget> {
  int? _selectedBrands;
  int? _selectedCategories;

  @override
  void initState() {
    super.initState();
    _selectedBrands = widget.selectedBrands;
    _selectedCategories = widget.selectedCategories;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final productBloc = BlocProvider.of<ProductBloc>(context);

    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(18.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Merek Produk
                const FormLabel(label: 'Merek Produk'),
                SizedBox(height: size.height * 0.01),
                DropdownButtonFormField<int>(
                  value: _selectedBrands,
                  hint: Text('Pilih Merek'),
                  isExpanded: true,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  // In your ProductDropdownWidget build method
                  items: productBloc.brands.isNotEmpty
                      ? productBloc.brands.map((brand) {
                          return DropdownMenuItem<int>(
                            value: brand['id'] is int
                                ? brand['id']
                                : (brand['id'] != null
                                    ? int.tryParse(brand['id'].toString())
                                    : null),
                            child: Text(brand['brand_name'] ?? 'Unknown'),
                          );
                        }).toList()
                      : [
                          DropdownMenuItem<int>(
                              value: null, child: Text('No brands available'))
                        ],
                  onChanged: (value) {
                    setState(() {
                      _selectedBrands = value;
                    });
                    if (widget.onBrandChanged != null) {
                      widget.onBrandChanged!(value);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(18.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FormLabel(label: 'Kategori Produk'),
                SizedBox(height: size.height * 0.01),
                DropdownButtonFormField<int>(
                  value: _selectedCategories,
                  hint: Text('Pilih Kategori'),
                  isExpanded: true,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  items: productBloc.categories.isNotEmpty
                      ? productBloc.categories.map((category) {
                          return DropdownMenuItem<int>(
                            value: category['id'] is int
                                ? category['id']
                                : (category['id'] != null
                                    ? int.tryParse(category['id'].toString())
                                    : null),
                            child: Text(category['category_name'] ?? 'Unknown'),
                          );
                        }).toList()
                      : [
                          DropdownMenuItem<int>(
                              value: null,
                              child: Text('No categories available'))
                        ],
                  onChanged: (value) {
                    setState(() {
                      _selectedCategories = value;
                    });
                    if (widget.onCategoryChanged != null) {
                      widget.onCategoryChanged!(value);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
