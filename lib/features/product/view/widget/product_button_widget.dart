import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:neo_admin/constant/widget/alert_dialog.dart';

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
          heroTag: 'saveProductButton',
          backgroundColor: Color(0xFFA67A4D),
          tooltip: 'Simpan produk',
          onPressed: () {
            saveButton();
          },
          child: Icon(IconlyBold.upload),
        ),
        SizedBox(height: size.height * 0.01),
        FloatingActionButton(
          heroTag: 'cancelProductButton',
          backgroundColor: Color(0xFFA67A4D),
          tooltip: 'Batal',
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialogWarning(
                label: 'Batal edit produk',
                function: () {
                  context.go('/main/product');
                },
              ),
            );
          },
          child: Icon(IconlyBold.close_square),
        ),
      ],
    );
  }
}
