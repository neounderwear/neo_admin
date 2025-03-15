import 'package:flutter/material.dart';
import 'package:neo_admin/constant/widget/section_header.dart';
import 'package:neo_admin/features/dashboard/view/widget/data_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(text: 'Beranda'),
              SizedBox(height: 24.0),
              Wrap(
                children: [
                  Row(
                    children: [
                      DataCard(
                        width: 400.0,
                        height: 200.0,
                        data: '0',
                        label: 'Jumlah Banner',
                      ),
                      DataCard(
                        width: 400.0,
                        height: 200.0,
                        data: '0',
                        label: 'Jumlah Kategori',
                      ),
                      DataCard(
                        width: 400.0,
                        height: 200.0,
                        data: '0',
                        label: 'Jumlah Merek',
                      ),
                      DataCard(
                        width: 400.0,
                        height: 200.0,
                        data: '0',
                        label: 'Jumlah Produk',
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  DataCard(
                    width: 1200.0,
                    height: 500.0,
                    data: '0',
                    label: 'Jumlah Pesanan',
                  ),
                  DataCard(
                    width: 400.0,
                    height: 500.0,
                    data: '0',
                    label: 'Jumlah Customer',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
