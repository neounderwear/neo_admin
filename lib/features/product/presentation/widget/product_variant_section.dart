import 'package:flutter/material.dart';
import 'package:neo_admin/constant/widget/form_label.dart';

class ProductVariantSection extends StatefulWidget {
  const ProductVariantSection({super.key});
  @override
  State<ProductVariantSection> createState() => _ProductVariantSectionState();
}

class _ProductVariantSectionState extends State<ProductVariantSection> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormLabel(label: 'Putih, M'),
        SizedBox(height: size.height * 0.01),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FormLabel(label: 'Harga Jual'),
                  SizedBox(height: size.height * 0.01),
                  SizedBox(
                    height: size.height * 0.05,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        hintText: 'Harga jual produk',
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 14.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: size.width * 0.01),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FormLabel(label: 'Harga Reseller'),
                  SizedBox(height: size.height * 0.01),
                  SizedBox(
                    height: size.height * 0.05,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        hintText: 'Harga reseller',
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 14.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: size.width * 0.01),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FormLabel(label: 'SKU Produk'),
                  SizedBox(height: size.height * 0.01),
                  SizedBox(
                    height: size.height * 0.05,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        hintText: 'SKU Produk',
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 14.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: size.width * 0.01),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FormLabel(label: 'Stok'),
                  SizedBox(height: size.height * 0.01),
                  SizedBox(
                    height: size.height * 0.05,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        hintText: 'Stok produk',
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 14.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: size.width * 0.01),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FormLabel(label: 'Berat (gr)'),
                  SizedBox(height: size.height * 0.01),
                  SizedBox(
                    height: size.height * 0.05,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        hintText: 'Berat produk',
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
        Divider(color: Colors.grey),
        SizedBox(height: size.height * 0.02),
      ],
    );
  }
}
