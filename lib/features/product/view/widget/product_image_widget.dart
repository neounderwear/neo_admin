import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:neo_admin/constant/widget/form_label.dart';

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
                DottedBorder(
                  color: Colors.grey,
                  strokeWidth: 1.0,
                  dashPattern: const [3, 2],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12.0),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: size.height * 0.2,
                      height: size.height * 0.2,
                      decoration: const BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate_rounded,
                            size: 48.0,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
