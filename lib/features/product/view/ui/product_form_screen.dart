import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:neo_admin/features/product/bloc/product_bloc.dart';
import 'package:neo_admin/features/product/bloc/product_event.dart';
import 'package:neo_admin/features/product/bloc/product_state.dart';
import 'package:neo_admin/features/product/view/widget/product_detail_section.dart';
import 'package:neo_admin/features/product/view/widget/product_dropdown_widget.dart';
import 'package:neo_admin/features/product/view/widget/product_image_widget.dart';
import 'package:neo_admin/features/product/view/widget/product_variant_widget.dart';

// Widget halaman untuk menambah/mengubah produk sebagai modal bottom sheet
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

  void submit() async {
    if (_formKey.currentState!.validate()) {
      final productBloc = BlocProvider.of<ProductBloc>(context);

      // Validasi SKU duplikat
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
        _showSnackBar('SKU sudah ada', Colors.yellow, Colors.white);
        return;
      }

      // Validasi merek dan kategori
      if (selectedBrands == null || selectedCategories == null) {
        _showSnackBar(
            'Merek dan Kategori harus dipilih', Colors.yellow, Colors.white);
        return;
      }

      try {
        if (widget.product == null) {
          // Tambah produk baru - gambar wajib ada
          if (productImageBytes == null) {
            _showSnackBar(
                'Gambar produk harus diisi', Colors.yellow, Colors.white);
            return;
          }

          productBloc.add(AddProducts(
            name: nameController.text,
            description: descController.text.trim(),
            brandId: selectedBrands!,
            categoryId: selectedCategories!,
            imageBytes: productImageBytes,
            variants: variants,
          ));
        } else {
          // Update produk yang ada - gambar opsional
          productBloc.add(UpdateProducts(
            productId: widget.product!['id'],
            name: nameController.text,
            description:
                descController.text.isEmpty ? null : descController.text,
            brandId: selectedBrands!,
            categoryId: selectedCategories!,
            imageBytes:
                productImageBytes, // Null jika tidak ada perubahan gambar
            variants: variants,
          ));
        }
      } catch (e) {
        _showSnackBar(
            'Terjadi kesalahan: ${e.toString()}', Colors.red, Colors.white);
      }
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
        behavior: SnackBarBehavior.fixed, // Changed from floating to fixed
        backgroundColor: bgColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.9, // Use 90% of screen height
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        children: [
          // Header with drag handle and title
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1.0,
                ),
              ),
            ),
            child: Column(
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 40.0,
                    height: 4.0,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                // Title
                Text(
                  widget.product == null ? 'Buat Produk Baru' : 'Edit Produk',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
                ),
              ],
            ),
          ),
          // Main content
          Expanded(
            child: BlocListener<ProductBloc, ProductState>(
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
                } else if (state is CategoriesLoaded &&
                    _tempCategoryId != null) {
                  // Cek apakah category_id ada dalam daftar categories
                  final categoryExists = state.categories
                      .any((category) => category['id'] == _tempCategoryId);
                  setState(() {
                    selectedCategories =
                        categoryExists ? _tempCategoryId : null;
                  });
                } else if (state is ProductSuccess) {
                  _showSnackBar(
                      'Berhasil mengupload produk', Colors.green, Colors.white);
                  // Gunakan delay sebelum navigasi untuk menghindari error
                  Future.delayed(Duration(milliseconds: 1500), () {
                    if (mounted) {
                      Navigator.of(context).pop();
                    }
                  });
                } else if (state is ProductError) {
                  _showSnackBar(
                      'Gagal mengupload produk', Colors.red, Colors.white);
                }
              },
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 16.0), // Adjusted padding for modal
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image section at the top for mobile view
                          Center(
                            child: ProductImageWidget(
                              initialImageBytes: imageBytes,
                              initialImageUrl: widget.product != null
                                  ? widget.product!['image_url']
                                  : null,
                              onImageSelected: (bytes) {
                                setState(() {
                                  productImageBytes = bytes;
                                  imageBytes = bytes;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),

                          // Product details
                          ProductDetailSection(
                            nameController: nameController,
                            descController: descController,
                          ),
                          SizedBox(height: size.height * 0.02),

                          // Dropdown for brands and categories
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
                          SizedBox(height: size.height * 0.02),

                          // Variants
                          ProductVariantWidget(
                            initialVariants: variants,
                            onVariantChanged: onVariantChanged,
                          ),
                          SizedBox(height: size.height * 0.04),

                          // Action buttons at the bottom
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Cancel button
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(Icons.close),
                                label: Text('Batal'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                ),
                              ),

                              // Save button
                              ElevatedButton.icon(
                                onPressed: () {
                                  try {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      if (mounted) submit();
                                    });
                                  } catch (e) {
                                    rethrow;
                                  }
                                },
                                icon: Icon(Icons.save),
                                label: Text('Simpan'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFA67A4D),
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
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
