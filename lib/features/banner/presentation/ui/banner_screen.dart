import 'package:flutter/material.dart';
import 'package:neo_admin/constant/widget/section_header.dart';
import 'package:neo_admin/features/banner/presentation/widget/add_banner_widget.dart';
import 'package:neo_admin/features/banner/presentation/widget/banner_table_widget.dart';

class BannerScreen extends StatelessWidget {
  const BannerScreen({super.key});

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
                          builder: (context) => AddBannerWidget(),
                        );
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24.0),
              BannerTableWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
