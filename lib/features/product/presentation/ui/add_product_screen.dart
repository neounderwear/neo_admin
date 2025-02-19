import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_admin/features/product/presentation/widget/product_attribute_section.dart';
import 'package:neo_admin/features/product/presentation/widget/product_brand_section.dart';
import 'package:neo_admin/features/product/presentation/widget/product_category_section.dart';
import 'package:neo_admin/features/product/presentation/widget/product_image_section.dart';
import 'package:neo_admin/features/product/presentation/widget/product_name_section.dart';
import 'package:neo_admin/features/product/presentation/widget/product_status_section.dart';
import 'package:neo_admin/features/product/presentation/widget/product_type_section.dart';
import 'package:neo_admin/features/product/presentation/widget/single_product_section.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buat Produk Baru',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          SizedBox(
            height: 39.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.brown,
                side: BorderSide(color: Colors.brown),
              ),
              onPressed: () {
                context.push('/main/product');
              },
              child: Text('Batalkan'),
            ),
          ),
          SizedBox(width: 12.0),
          SizedBox(
            height: 39.0,
            child: ElevatedButton(
              onPressed: () {
                context.push('/main/product');
              },
              child: Text('Simpan Produk'),
            ),
          ),
          SizedBox(width: 12.0),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    ProductNameSection(),
                    SizedBox(height: size.height * 0.02),
                    ProductTypeSection(),
                    SizedBox(height: size.height * 0.02),
                    SingleProductSection(),
                    SizedBox(height: size.height * 0.02),
                    ProductAttributeSection(),
                  ],
                ),
              ),
              SizedBox(width: size.width * 0.01),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    ProductImageSection(),
                    SizedBox(height: size.height * 0.02),
                    ProductBrandSection(),
                    SizedBox(height: size.height * 0.02),
                    ProductCategorySection(),
                    SizedBox(height: size.height * 0.02),
                    ProductStatusSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
