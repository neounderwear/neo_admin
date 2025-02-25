import 'package:flutter/material.dart';
import 'package:neo_admin/constant/widget/form_label.dart';

// Widget form untuk memilih tipe varian produk
// Tanpa atau dengan varian
class ProductTypeSection extends StatefulWidget {
  const ProductTypeSection({super.key});

  @override
  State<ProductTypeSection> createState() => _ProductTypeSectionState();
}

class _ProductTypeSectionState extends State<ProductTypeSection> {
  bool isSimpleProduct = true;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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
            // Tipe Produk
            const FormLabel(label: 'Tipe Produk'),
            SizedBox(height: size.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isSimpleProduct = true;
                        });
                      },
                      icon: Icon(
                        isSimpleProduct
                            ? Icons.radio_button_checked_rounded
                            : Icons.radio_button_unchecked_rounded,
                        color: isSimpleProduct
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                    ),
                    const Text('Tanpa Varian'),
                  ],
                ),
                const SizedBox(width: 20),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isSimpleProduct = false;
                        });
                      },
                      icon: Icon(
                        !isSimpleProduct
                            ? Icons.radio_button_checked_rounded
                            : Icons.radio_button_unchecked_rounded,
                        color: !isSimpleProduct
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                    ),
                    const Text('Dengan Varian'),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
