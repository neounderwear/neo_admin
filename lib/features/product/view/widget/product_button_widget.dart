import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

class ProductButtonWidget extends StatelessWidget {
  final Function saveButton;
  final Function? cancelButton;

  const ProductButtonWidget({
    super.key,
    required this.saveButton,
    this.cancelButton,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          backgroundColor: Color(0xFFA67A4D),
          tooltip: 'Simpan produk',
          onPressed: () {
            saveButton();
          },
          child: Icon(IconlyBold.upload),
        ),
        SizedBox(height: size.height * 0.01),
        FloatingActionButton(
          backgroundColor: Color(0xFFA67A4D),
          tooltip: 'Batal',
          onPressed: () {
            context.go('/main/product');
          },
          child: Icon(IconlyBold.close_square),
        ),
      ],
    );
  }
}
