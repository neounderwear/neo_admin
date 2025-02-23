import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_admin/constant/widget/section_header.dart';
import 'package:neo_admin/features/brand/bloc/brand_bloc.dart';
import 'package:neo_admin/features/brand/bloc/brand_event.dart';
import 'package:neo_admin/features/brand/bloc/brand_state.dart';
import 'package:neo_admin/features/brand/view/widget/brand_form_widget.dart';
import 'package:neo_admin/features/brand/view/widget/brand_table_widget.dart';

// Halaman utama merek produk
class BrandScreen extends StatefulWidget {
  const BrandScreen({super.key});

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BrandBloc>().add(LoadBrands());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SectionHeader(text: 'Merek'),
                  SizedBox(
                    height: 39.0,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(),
                      icon: const Icon(Icons.add),
                      label: const Text('Tambah Baru'),
                      onPressed: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => BrandFormWidget(),
                        );
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24.0),
              BlocBuilder<BrandBloc, BrandState>(builder: (context, state) {
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
                    child: BrandTableWidget(),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
