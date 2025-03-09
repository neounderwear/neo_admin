import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:neo_admin/constant/widget/form_label.dart';
import 'package:neo_admin/features/product/bloc/product_bloc.dart';
import 'package:neo_admin/features/product/bloc/product_event.dart';
import 'package:neo_admin/features/product/bloc/product_state.dart';
import 'package:neo_admin/features/product/view/widget/product_detail_section.dart';
import 'package:neo_admin/features/product/view/widget/product_dropdown_widget.dart';
import 'package:neo_admin/features/product/view/widget/product_image_widget.dart';

// Widget halaman untuk menambah/mengubah produk
class ProductFormScreen extends StatefulWidget {
  final Map<String, dynamic>? product;

  const ProductFormScreen({super.key, this.product});

  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  // Controller
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descController = TextEditingController();
  int? selectedBrands;
  int? selectedCategories;
  String? imageUrl;
  List<Map<String, dynamic>> variants = [];

  // Image handling
  Uint8List? productImageBytes;

  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();
    loadDropdownData();
    initializeForm();
  }

  void loadDropdownData() {
    final productBloc = BlocProvider.of<ProductBloc>(context);
    productBloc.add(LoadBrands());
    productBloc.add(LoadCategories());
  }

  void initializeForm() {
    if (widget.product != null) {
      nameController.text = widget.product!['name'] ?? '';
      descController.text = widget.product!['description'] ?? '';
      selectedBrands = widget.product!['brand_id'];
      selectedCategories = widget.product!['category_id'];

      if (widget.product!.containsKey('product_variants')) {
        for (var variant in widget.product!['product_variants']) {
          variants.add({
            'id': variant['id'],
            'name': variant['name'],
            'sku': variant['sku'],
            'price': variant['price'],
            'discount_price': variant['discount_price'],
            'reseller_price': variant['reseller_price'],
            'stock': variant['stock'],
            'weight': variant['weight'],
          });
        }
      }

      selectedBrands = widget.product!['brand_id'] is int
          ? widget.product!['brand_id']
          : (widget.product!['brand_id'] != null
              ? int.tryParse(widget.product!['brand_id'].toString())
              : null);

      selectedCategories = widget.product!['category_id'] is int
          ? widget.product!['category_id']
          : (widget.product!['category_id'] != null
              ? int.tryParse(widget.product!['category_id'].toString())
              : null);
    }
  }

  void addVariant() {
    setState(() {
      variants.add({
        'name': '',
        'sku': '',
        'price': 0,
        'discount_price': 0,
        'reseller_price': 0,
        'stock': 0,
        'weight': 0,
      });
    });
  }

  void removeVariant(int index) {
    setState(() {
      variants.removeAt(index);
    });
  }

  void updateVariant(int index, String key, dynamic value) {
    setState(() {
      variants[index][key] = value;
    });
  }

  bool isSkuUnique(String sku, int currentIndex) {
    for (int i = 0; i < variants.length; i++) {
      if (i != currentIndex && variants[i]['sku'] == sku) {
        return false;
      }
    }
    return true;
  }

  void saveProduct() async {
    if (_formKey.currentState!.validate()) {
      final productBloc = BlocProvider.of<ProductBloc>(context);

      final Set<String> skuSet = {};
      bool hasDuplicateSku = false;

      for (int i = 0; i < variants.length; i++) {
        final sku = variants[i]['sku'].toString();
        if (skuSet.contains(sku)) {
          hasDuplicateSku = true;
          break;
        }
        skuSet.add(sku);
      }

      if (hasDuplicateSku) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'SKU sudah ada',
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.yellow,
            width: 300.0,
          ),
        );

        return;
      }

      if (productImageBytes != null) {
        try {
          imageUrl = await productBloc.uploadImage(productImageBytes!);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Gagal mengupload gambar',
                style: TextStyle(color: Colors.white),
              ),
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              width: 300.0,
            ),
          );

          return;
        }
      }

      if (widget.product == null) {
        if (selectedBrands == null || selectedCategories == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Merek dan Kategori harus dipilih',
                style: TextStyle(color: Colors.white),
              ),
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.yellow,
              width: 300.0,
            ),
          );

          return;
        }
        productBloc.add(AddProducts(
          name: nameController.text,
          description: descController.text.trim(),
          brandId: selectedBrands!,
          categoryId: selectedCategories!,
          imageUrl: '',
          variants: variants,
        ));
      } else {
        if (selectedBrands == null || selectedCategories == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Merek dan Kategori harus dipilih',
                style: TextStyle(color: Colors.white),
              ),
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.yellow,
              width: 300.0,
            ),
          );
          return;
        }
        productBloc.add(UpdateProducts(
          productId: widget.product!['id'],
          name: nameController.text,
          description: descController.text.isEmpty ? null : descController.text,
          brandId: selectedBrands!,
          categoryId: selectedCategories!,
          imageUrl: widget.product!['image_url'],
          variants: variants,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product == null ? 'Buat Produk Baru' : 'Edit Produk',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ImageUploadSuccessState) {
            setState(() {
              imageUrl = state.imageUrl;
            });
          } else if (state is ProductSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Berhasil mengupload produk',
                  style: TextStyle(color: Colors.white),
                ),
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
                width: 300.0,
              ),
            );
            context.go('/main/product');
          } else if (state is ProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Gagal mengupload produk',
                  style: TextStyle(color: Colors.white),
                ),
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
                width: 300.0,
              ),
            );
          }
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 128.0, vertical: 18.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              // Nama dan Deskripsi Produk
                              ProductDetailSection(
                                nameController: nameController,
                                descController: descController,
                              ),
                              SizedBox(height: size.height * 0.02),

                              // Varian produk
                              
                              SizedBox(height: size.height * 0.02),
                            ],
                          ),
                        ),
                        SizedBox(width: size.width * 0.01),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              // Foto produk
                              ProductImageWidget(onImageSelected: (bytes) {
                                setState(() {
                                  productImageBytes = bytes;
                                });
                              }),
                              SizedBox(height: size.height * 0.02),
                              ProductDropdownWidget(
                                selectedBrands: selectedBrands,
                                selectedCategories: selectedCategories,
                                onBrandChanged: (value) {
                                  setState(() {
                                    selectedBrands = value;
                                  });
                                },
                                onCategoryChanged: (value) {
                                  setState(() {
                                    selectedCategories = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Color(0xFFA67A4D),
            tooltip: 'Simpan produk',
            onPressed: () {
              saveProduct();
            },
            child: Icon(IconlyBold.upload),
          ),
          SizedBox(height: size.height * 0.01),
          FloatingActionButton(
            backgroundColor: Color(0xFFA67A4D),
            tooltip: 'Batal',
            onPressed: () => context.go('/main/product'),
            child: Icon(IconlyBold.close_square),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    super.dispose();
  }
}
