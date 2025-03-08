import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconly/iconly.dart';
import 'package:neo_admin/constant/asset_manager.dart';
import 'package:neo_admin/constant/color.dart';
import 'package:neo_admin/constant/widget/alert_dialog.dart';
import 'package:neo_admin/features/category/bloc/category_bloc.dart';
import 'package:neo_admin/features/category/bloc/category_event.dart';
import 'package:neo_admin/features/category/bloc/category_state.dart';
import 'package:neo_admin/features/category/view/widget/category_form_widget.dart';

// Widget untuk menampilkan kategori produk
// dalam bentuk tabel
class CategoryTableWidget extends StatelessWidget {
  const CategoryTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(
            child: SpinKitThreeBounce(
              color: Colors.brown,
              size: 36.0,
            ),
          );
        }
        if (state is CategoryLoaded) {
          if (state.categories.isEmpty) {
            return const Center(
              child: Text('Kamu belum menambahkan kategori. Tambah sekarang'),
            );
          }

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
                  label: Text('Icon'),
                ),
                DataColumn(
                  headingRowAlignment: MainAxisAlignment.center,
                  label: Text('Kategori'),
                ),
                DataColumn(
                  headingRowAlignment: MainAxisAlignment.center,
                  label: Text('Aksi'),
                ),
              ],
              rows: state.categories.map(
                (category) {
                  return DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                category['image_url'],
                                width: 150,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.broken_image,
                                      size: 50);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataCell(Center(child: Text(category['category_name']))),
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
                                    builder: (context) =>
                                        CategoryFormWidget(category: category),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(IconlyBold.delete, size: 18),
                                onPressed: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => AlertDialogWarning(
                                      label:
                                          'Kategori bakalan dihapus permanen',
                                      function: () {
                                        context.read<CategoryBloc>().add(
                                              DeleteCategories(
                                                category['id'].toString(),
                                              ),
                                            );
                                        Navigator.of(context).pop();
                                        DelightToastBar(
                                          builder: (context) {
                                            return ToastCard(
                                              leading: Image.asset(
                                                  AssetManager.successIcon),
                                              title: const Text(
                                                  'Berhasil menghapus kategori'),
                                              color: const Color(0xFFD9C7B3),
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
                      ),
                    ],
                  );
                },
              ).toList(),
            ),
          );
        }
        return const Center(
          child: Text('Kamu belum menambahkan kategori. Tambah sekarang'),
        );
      },
    );
  }
}
