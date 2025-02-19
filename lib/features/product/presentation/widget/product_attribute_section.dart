import 'package:flutter/material.dart';
import 'package:neo_admin/constant/widget/form_label.dart';
import 'package:neo_admin/features/product/presentation/widget/product_variant_section.dart';

class ProductAttributeSection extends StatefulWidget {
  const ProductAttributeSection({super.key});
  @override
  State<ProductAttributeSection> createState() =>
      _ProductAttributeSectionState();
}

class _ProductAttributeSectionState extends State<ProductAttributeSection> {
  String? selectedVariant;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Form Tipe Varian
                      const FormLabel(label: 'Tipe Varian'),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedVariant,
                                hint: const Text("Pilih"),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedVariant = newValue;
                                  });
                                },
                                items: [
                                  'Ukuran',
                                  'Warna',
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
                SizedBox(width: size.width * 0.01),
                // Form Nama Varian
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FormLabel(label: 'Varian'),
                      SizedBox(height: size.height * 0.01),
                      SizedBox(
                        height: size.height * 0.05,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                            hintText: 'Masukkan varian',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 14.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.02),
            SizedBox(
              height: size.height * 0.05,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Tambah Varian'),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            ProductVariantSection(),
            ProductVariantSection(),
          ],
        ),
      ),
    );
  }
}
