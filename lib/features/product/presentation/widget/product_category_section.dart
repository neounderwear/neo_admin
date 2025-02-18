import 'package:flutter/material.dart';
import 'package:neo_admin/constant/widget/form_label.dart';

class ProductCategorySection extends StatefulWidget {
  const ProductCategorySection({super.key});

  @override
  State<ProductCategorySection> createState() => _ProductCategorySectionState();
}

class _ProductCategorySectionState extends State<ProductCategorySection> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
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
            // Form Kategori Produk
            const FormLabel(label: 'Kategori Produk'),
            SizedBox(height: size.height * 0.01),
            SizedBox(
              height: size.height * 0.05,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedValue,
                      hint: const Text("Pilih"),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue;
                        });
                      },
                      items: [
                        'Pria',
                        'Wanita',
                        'Anak-anak',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
