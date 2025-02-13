import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:neo_admin/constant/color.dart';
import 'package:neo_admin/features/category/presentation/widget/update_category_widget.dart';

class CategoryTableWidget extends StatefulWidget {
  const CategoryTableWidget({super.key});

  @override
  State<CategoryTableWidget> createState() => _CategoryTableWidgetState();
}

class _CategoryTableWidgetState extends State<CategoryTableWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DataTable(
        columnSpacing: 0,
        dataRowMinHeight: 100,
        dataRowMaxHeight: 120,
        border: TableBorder.all(color: Colors.grey.shade300),
        headingRowColor: WidgetStateProperty.all(AppColor.secondaryColor),
        headingTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        columns: const <DataColumn>[
          DataColumn(
            headingRowAlignment: MainAxisAlignment.center,
            label: Text('Foto'),
          ),
          DataColumn(
            headingRowAlignment: MainAxisAlignment.center,
            label: Text('Kategori'),
          ),
          DataColumn(
            headingRowAlignment: MainAxisAlignment.center,
            label: Text('Status'),
          ),
          DataColumn(
            headingRowAlignment: MainAxisAlignment.center,
            label: Text('Aksi'),
          ),
        ],
        rows: <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1614850715649-1d0106293bd1?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              )),
              DataCell(Center(child: Text('Pria'))),
              DataCell(Center(child: Text('Aktif'))),
              DataCell(
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(IconlyBold.edit, size: 18.0),
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => UpdateCategoryWidget(),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(IconlyBold.delete, size: 18),
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Hapus Kategori?'),
                                content: const Text(
                                    'Kategori bakalan dihapus permanen'),
                                actions: [
                                  TextButton(
                                    child: const Text('Batal'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text(
                                      'Hapus',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () {},
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
