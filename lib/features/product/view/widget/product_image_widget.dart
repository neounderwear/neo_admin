import 'package:flutter/material.dart';
import 'package:neo_admin/constant/widget/form_label.dart';
import 'package:neo_admin/features/product/view/widget/add_product_image.dart';

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AddProductImage(
                  width: size.height * 0.2,
                  height: size.height * 0.2,
                ),
                SizedBox(width: size.width * 0.01),
                AddProductImage(
                  width: size.height * 0.2,
                  height: size.height * 0.2,
                ),
                SizedBox(width: size.width * 0.01),
                AddProductImage(
                  width: size.height * 0.2,
                  height: size.height * 0.2,
                ),
                SizedBox(width: size.width * 0.01),
                AddProductImage(
                  width: size.height * 0.2,
                  height: size.height * 0.2,
                ),
                SizedBox(width: size.width * 0.01),
                AddProductImage(
                  width: size.height * 0.2,
                  height: size.height * 0.2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
