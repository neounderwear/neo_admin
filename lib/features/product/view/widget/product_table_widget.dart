import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:neo_admin/constant/asset_manager.dart';
import 'package:neo_admin/constant/color.dart';
import 'package:neo_admin/constant/widget/alert_dialog.dart';

class ProductTableWidget extends StatefulWidget {
  const ProductTableWidget({super.key});

  @override
  State<ProductTableWidget> createState() => _ProductTableWidgetState();
}

class _ProductTableWidgetState extends State<ProductTableWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DataTable(
          columnSpacing: 16,
          dataRowMinHeight: 80,
          dataRowMaxHeight: 100,
          border: TableBorder.all(color: Colors.grey.shade300),
          headingRowColor: WidgetStateProperty.all(AppColor.secondaryColor),
          headingTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          columns: const <DataColumn>[
            DataColumn(
              headingRowAlignment: MainAxisAlignment.center,
              label: Text('Produk'),
            ),
            DataColumn(
              headingRowAlignment: MainAxisAlignment.center,
              label: Text('Harga'),
            ),
            DataColumn(
              headingRowAlignment: MainAxisAlignment.center,
              label: Text('Stok'),
            ),
            DataColumn(
              headingRowAlignment: MainAxisAlignment.center,
              label: Text('Penjualan'),
            ),
            DataColumn(
              headingRowAlignment: MainAxisAlignment.center,
              label: Text('Aktif'),
            ),
            DataColumn(
              headingRowAlignment: MainAxisAlignment.center,
              label: Text('Atur'),
            ),
          ],
          rows: [
            DataRow(
              cells: <DataCell>[
                DataCell(
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          '',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.broken_image),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Text('product.name'),
                    ],
                  ),
                ),
                DataCell(Center(child: Text('product.price.toString()'))),
                DataCell(Center(child: Text('product.stock.toString()'))),
                DataCell(Center(child: Text('0'))),
                DataCell(
                  Center(
                    child: Switch(value: false, onChanged: (bool) {}),
                  ),
                ),
                DataCell(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(IconlyBold.edit, size: 18.0),
                        onPressed: () {
                          // Implementasi edit produk
                        },
                      ),
                      IconButton(
                        icon: const Icon(IconlyBold.delete,
                            size: 18, color: Colors.red),
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) =>
                                AlertDialogWarning(
                              label: 'Produk bakalan dihapus permanen',
                              function: () {
                                Navigator.of(context).pop();
                                DelightToastBar(
                                  builder: (context) {
                                    return ToastCard(
                                      leading:
                                          Image.asset(AssetManager.successIcon),
                                      title: Text('Berhasil menghapus produk'),
                                      color: Color(0xFFD9C7B3),
                                    );
                                  },
                                  autoDismiss: true,
                                  position: DelightSnackbarPosition.top,
                                ).show(context);
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]),
    );
  }
}
