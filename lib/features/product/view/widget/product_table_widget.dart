import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:neo_admin/constant/color.dart';

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
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Text('Name'),
                    ],
                  ),
                ),
                DataCell(Center(child: Text('Rp. 100'))),
                DataCell(Center(child: Text('10'))),
                DataCell(Center(child: Text('10'))),
                DataCell(
                  Center(
                    child: Switch(
                      value: true,
                      onChanged: (bool value) {
                        setState(() {
                          value = false;
                        });
                      },
                    ),
                  ),
                ),
                DataCell(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(IconlyBold.edit, size: 18.0),
                        onPressed: () {
                          // TODO: Tambahkan logika edit
                        },
                      ),
                      IconButton(
                        icon: const Icon(IconlyBold.delete,
                            size: 18, color: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Hapus Produk?'),
                                content: const Text(
                                    'Produk ini akan dihapus secara permanen.'),
                                actions: [
                                  TextButton(
                                    child: const Text('Batal'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Hapus',
                                        style: TextStyle(color: Colors.red)),
                                    onPressed: () {
                                      // TODO: Tambahkan logika hapus
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )
          ]),
    );
  }
}
