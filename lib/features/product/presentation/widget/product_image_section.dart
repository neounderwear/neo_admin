import 'package:flutter/material.dart';
import 'package:neo_admin/constant/widget/form_label.dart';
import 'package:neo_admin/features/product/presentation/widget/add_product_image.dart';

class ProductImageSection extends StatefulWidget {
  const ProductImageSection({super.key});

  @override
  State<ProductImageSection> createState() => _ProductImageSectionState();
}

class _ProductImageSectionState extends State<ProductImageSection> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(18.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormLabel(label: 'Foto Produk'),
            SizedBox(height: size.height * 0.01),
            AddProductImage(width: double.infinity, height: size.height * 0.3),
            SizedBox(
              height: size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AddProductImage(
                  width: size.height * 0.1,
                  height: size.height * 0.1,
                ),
                AddProductImage(
                  width: size.height * 0.1,
                  height: size.height * 0.1,
                ),
                AddProductImage(
                  width: size.height * 0.1,
                  height: size.height * 0.1,
                ),
                AddProductImage(
                  width: size.height * 0.1,
                  height: size.height * 0.1,
                ),
                AddProductImage(
                  width: size.height * 0.1,
                  height: size.height * 0.1,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
