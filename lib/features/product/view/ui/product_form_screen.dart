import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:neo_admin/features/product/bloc/product_bloc.dart';
import 'package:neo_admin/features/product/bloc/product_event.dart';
import 'package:neo_admin/features/product/bloc/product_state.dart';
import 'package:neo_admin/features/product/view/widget/product_button_widget.dart';
import 'package:neo_admin/features/product/view/widget/product_detail_section.dart';
import 'package:neo_admin/features/product/view/widget/product_dropdown_widget.dart';
import 'package:neo_admin/features/product/view/widget/product_image_widget.dart';
import 'package:neo_admin/features/product/view/widget/product_variant_widget.dart';

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
  Uint8List? imageBytes;

  List<Map<String, dynamic>> variants = [];
  int? _tempBrandId;
  int? _tempCategoryId;

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

      // Simpan nilai sementara sebelum divalidasi
      final tmpBrandId = widget.product!['brand_id'] is int
          ? widget.product!['brand_id']
          : (widget.product!['brand_id'] != null
              ? int.tryParse(widget.product!['brand_id'].toString())
              : null);

      final tmpCategoryId = widget.product!['category_id'] is int
          ? widget.product!['category_id']
          : (widget.product!['category_id'] != null
              ? int.tryParse(widget.product!['category_id'].toString())
              : null);

      // Jangan langsung atur selectedBrands dan selectedCategories
      // Kita akan atur nanti setelah data brands dan categories dimuat

      // Simpan ID ini untuk divalidasi nanti
      _tempBrandId = tmpBrandId;
      _tempCategoryId = tmpCategoryId;
    }
  }

  // Function untuk handle perubahan variant dari ProductVariantWidget
  void onVariantChanged(List<Map<String, dynamic>> updatedVariants) {
    setState(() {
      variants = updatedVariants;
    });
  }

  void submit() {
    // Validasi form sebelum proses
    if (!_formKey.currentState!.validate()) return;

    // Periksa duplikat SKU
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
      _showSnackBar('SKU sudah ada', Colors.yellow, Colors.black);
      return;
    }

    // Validasi dropdown
    if (selectedBrands == null || selectedCategories == null) {
      _showSnackBar(
          'Merek dan Kategori harus dipilih', Colors.yellow, Colors.black);
      return;
    }

    // Validasi variants tidak boleh kosong
    if (variants.isEmpty) {
      _showSnackBar('Produk harus memiliki minimal 1 varian', Colors.yellow,
          Colors.black);
      return;
    }

    final productBloc = BlocProvider.of<ProductBloc>(context);

    // Untuk produk baru
    if (widget.product == null) {
      // Validasi image harus ada untuk produk baru
      if (imageBytes == null) {
        _showSnackBar(
            'Gambar produk harus diupload', Colors.yellow, Colors.black);
        return;
      }

      productBloc.add(AddProducts(
        name: nameController.text.trim(),
        description: descController.text.trim(),
        brandId: selectedBrands!,
        categoryId: selectedCategories!,
        imageBytes: imageBytes!,
        variants: variants,
      ));
    }
    // Untuk update produk
    else {
      productBloc.add(UpdateProducts(
        productId: widget.product!['id'],
        name: nameController.text.trim(),
        description: descController.text.trim(),
        brandId: selectedBrands!,
        categoryId: selectedCategories!,
        imageBytes: imageBytes!,
        variants: variants,
      ));
    }
  }

// Fungsi helper untuk menampilkan snackbar
  void _showSnackBar(String message, Color bgColor, Color textColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor),
        ),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: bgColor,
        width: 300.0,
      ),
    );
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
          } else if (state is BrandsLoaded && _tempBrandId != null) {
            // Cek apakah brand_id ada dalam daftar brands
            final brandExists =
                state.brands.any((brand) => brand['id'] == _tempBrandId);
            setState(() {
              selectedBrands = brandExists ? _tempBrandId : null;
            });
          } else if (state is CategoriesLoaded && _tempCategoryId != null) {
            // Cek apakah category_id ada dalam daftar categories
            final categoryExists = state.categories
                .any((category) => category['id'] == _tempCategoryId);
            setState(() {
              selectedCategories = categoryExists ? _tempCategoryId : null;
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
            // Gunakan delay sebelum navigasi untuk menghindari error
            Future.delayed(Duration(milliseconds: 1500), () {
              if (mounted) {
                Navigator.of(context).pop();
              }
            });
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
                              ProductVariantWidget(
                                initialVariants: variants,
                                onVariantChanged: onVariantChanged,
                              ),
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
                              ProductImageWidget(
                                initialImageBytes: imageBytes,
                                initialImageUrl: widget.product != null
                                    ? widget.product!['image_url']
                                    : null,
                                onImageSelected: (bytes) {
                                  setState(() {
                                    productImageBytes = bytes;
                                    imageBytes =
                                        bytes; // Update imageBytes juga untuk submit
                                  });
                                },
                              ),
                              SizedBox(height: size.height * 0.02),

                              // Merek dan Kategori produk
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
      floatingActionButton: ProductButtonWidget(
        saveButton: () {
          // Bungkus dengan try-catch untuk menangkap exception
          try {
            // Jika submit adalah async, pastikan dihandle dengan benar
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) submit();
            });
          } catch (e) {
            print("Error saat submit: $e");
          }
        },
        // ...
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
