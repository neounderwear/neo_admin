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
import 'package:neo_admin/features/banner/bloc/banner_bloc.dart';
import 'package:neo_admin/features/banner/bloc/banner_state.dart';
import 'package:neo_admin/features/banner/bloc/banner_event.dart';
import 'package:neo_admin/features/banner/view/widget/banner_form_widget.dart';

// Widget untuk menampilkan daftar banner
// dalam bentuk tabel
class BannerTableWidget extends StatelessWidget {
  const BannerTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerBloc, BannerState>(
      builder: (context, state) {
        if (state is BannerLoading) {
          return Center(
            child: SpinKitThreeBounce(
              color: Colors.brown,
              size: 36.0,
            ),
          );
        }

        if (state is BannerLoaded) {
          if (state.banners.isEmpty) {
            return const Center(
              child: Text('Kamu belum menambahkan banner. Tambah sekarang'),
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
                  label: Text('Banner'),
                ),
                DataColumn(
                  headingRowAlignment: MainAxisAlignment.center,
                  label: Text('Halaman'),
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
              rows: state.banners.map(
                (banner) {
                  return DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                banner['image_url'],
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
                      DataCell(Center(child: Text(banner['page']))),
                      DataCell(
                        Center(
                          child: Text(
                            banner['is_active'] ? 'Aktif' : 'Tidak Aktif',
                            style: TextStyle(
                              color: banner['is_active']
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(IconlyBold.edit, size: 18),
                                onPressed: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => BannerFormWidget(
                                      banner: banner,
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(IconlyBold.delete, size: 18),
                                onPressed: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialogWarning(
                                      label: 'Banner bakalan dihapus permanen',
                                      function: () {
                                        context.read<BannerBloc>().add(
                                              DeleteBanners(
                                                banner['id'].toString(),
                                              ),
                                            );
                                        Navigator.of(context).pop();
                                        DelightToastBar(
                                          builder: (context) {
                                            return ToastCard(
                                              leading: Image.asset(
                                                  AssetManager.successIcon),
                                              title: Text(
                                                  'Berhasil menghapus banner'),
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
                      ),
                    ],
                  );
                },
              ).toList(),
            ),
          );
        }

        if (state is BannerError) {
          return Center(child: Text('Error: ${state.message}'));
        }

        return const Center(
            child: Text('Kamu belum menambah banner. Tambah sekarang'));
      },
    );
  }
}
