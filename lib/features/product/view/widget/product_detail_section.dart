// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:neo_admin/constant/widget/form_label.dart';

// Widget form untuk input nama dan deskripsi produk
class ProductDetailSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descController;

  const ProductDetailSection({
    super.key,
    required this.nameController,
    required this.descController,
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
                controller: nameController,
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama produk harus diisi';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: size.height * 0.02),
            // Form Deskripsi Produk
            const FormLabel(label: 'Deskripsi Produk'),
            SizedBox(height: size.height * 0.01),
            TextFormField(
              controller: descController,
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
