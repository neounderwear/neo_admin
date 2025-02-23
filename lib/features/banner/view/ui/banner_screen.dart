import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_admin/constant/widget/section_header.dart';
import 'package:neo_admin/features/banner/bloc/banner_bloc.dart';
import 'package:neo_admin/features/banner/bloc/banner_event.dart';
import 'package:neo_admin/features/banner/bloc/banner_state.dart';
import 'package:neo_admin/features/banner/view/widget/banner_form_widget.dart';
import 'package:neo_admin/features/banner/view/widget/banner_table_widget.dart';

// Halaman utama banner toko
class BannerScreen extends StatefulWidget {
  const BannerScreen({super.key});

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BannerBloc>().add(LoadBanners());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SectionHeader(text: 'Banner'),
                  SizedBox(
                    height: 39.0,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text('Tambah Baru'),
                      onPressed: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => BannerFormWidget(),
                        );
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24.0),
              BlocBuilder<BannerBloc, BannerState>(
                builder: (context, state) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0,
                        vertical: 24.0,
                      ),
                      child: BannerTableWidget(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
