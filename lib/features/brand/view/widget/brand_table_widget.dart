import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconly/iconly.dart';
import 'package:neo_admin/constant/color.dart';
import 'package:neo_admin/constant/widget/alert_dialog.dart';
import 'package:neo_admin/features/brand/bloc/brand_bloc.dart';
import 'package:neo_admin/features/brand/bloc/brand_event.dart';
import 'package:neo_admin/features/brand/bloc/brand_state.dart';
import 'package:neo_admin/features/brand/view/widget/brand_form_widget.dart';

// Widget untuk menampilkan merek produk
// dalam bentuk tabel
class BrandTableWidget extends StatelessWidget {
  const BrandTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandBloc, BrandState>(
      builder: (context, state) {
        if (state is BrandLoading) {
          return const Center(
            child: SpinKitThreeBounce(
              color: Colors.brown,
              size: 36.0,
            ),
          );
        }

        if (state is BrandError) {
          return Center(child: Text('Error: ${state.message}'));
        }

        if (state is BrandLoaded) {
          if (state.brands.isEmpty) {
            return const Center(
              child: Text('Kamu belum menambahkan merek. Tambah sekarang'),
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
                  label: Text('Logo'),
                ),
                DataColumn(
                  headingRowAlignment: MainAxisAlignment.center,
                  label: Text('Nama'),
                ),
                DataColumn(
                  headingRowAlignment: MainAxisAlignment.center,
                  label: Text('Aksi'),
                ),
              ],
              rows: state.brands.map(
                (brand) {
                  return DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                brand['image_url'],
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
                      DataCell(Center(child: Text(brand['brand_name']))),
                      DataCell(
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(IconlyBold.edit, size: 18.0),
                                onPressed: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) =>
                                        BrandFormWidget(brand: brand),
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
                                      label: 'Merek bakalan dihapus permanen',
                                      function: () {
                                        context.read<BrandBloc>().add(
                                              DeleteBrands(
                                                brand['id'].toString(),
                                              ),
                                            );
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Berhasil menghapus merek',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            duration: Duration(seconds: 2),
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.green,
                                            width: 300.0,
                                          ),
                                        );
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
          child: Text('Kamu belum menambahkan merek. Tambah sekarang'),
        );
      },
    );
  }
}
