import 'package:flutter/material.dart';
import 'package:neo_admin/constant/widget/form_label.dart';

// Widget form untuk input nama dan deskripsi produk
class ProductDetailSection extends StatelessWidget {
  const ProductDetailSection({
    super.key,
  });

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
            // Form Nama Produk
            const FormLabel(label: 'Nama Produk'),
            SizedBox(height: size.height * 0.01),
            SizedBox(
              height: size.height * 0.05,
              child: TextFormField(
                //initialValue: product.productName,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  hintText: 'Nama Produk',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Nama produk harus diisi' : null,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            // Form Deskripsi Produk
            const FormLabel(label: 'Deskripsi Produk'),
            SizedBox(height: size.height * 0.01),
            TextFormField(
              //initialValue: product.productDesc,
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              textInputAction: TextInputAction.newline,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                hintText: 'Deskripsi Produk',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
