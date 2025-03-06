import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:neo_admin/constant/widget/form_label.dart';
import 'package:neo_admin/features/product/bloc/product_bloc.dart';
import 'package:neo_admin/features/product/bloc/product_event.dart';
import 'package:neo_admin/features/product/bloc/product_state.dart';
import 'package:neo_admin/features/product/data/product_service.dart';
import 'package:neo_admin/features/product/view/widget/product_detail_section.dart';
import 'package:neo_admin/features/product/view/widget/product_image_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Widget halaman untuk menambah/mengubah produk
class ProductFormScreen extends StatefulWidget {
  final Map<String, dynamic>? product;
  const ProductFormScreen({super.key, this.product});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  // Service
  final ProductService service = ProductService();

  // brands and categories
  List<Map<String, dynamic>> brands = [];
  List<Map<String, dynamic>> categories = [];

  // Controller
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descController = TextEditingController();

  // Nilai dropdown
  int? selectedBrand;
  int? selectedCategory;

  // Image handling
  String? imageUrl;

  // manajemen varian
  List<Map<String, dynamic>> variants = [];

  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    loadBrandsCategories();
    if (widget.product != null) {
      nameController.text = widget.product!['name'] ?? '';
      descController.text = widget.product!['description'] ?? '';
      imageUrl = widget.product!['image_url'] ?? '';
      selectedBrand = widget.product!['brand'];
      selectedCategory = widget.product!['category'];
      loadProductVariants();
    }
  }

  void loadProductVariants() {
    if (widget.product == null) return;

    final bloc = context.read<ProductBloc>();
    bloc.productService
        .fetchVariants(widget.product!['id'])
        .then((existingVariants) {
      setState(() {
        variants = existingVariants;
      });
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading variants: $e')),
      );
    });
  }

  Future<void> loadBrandsCategories() async {
    final brandData = await service.fetchBrands();
    final categoryData = await service.fetchCategories();

    if (brandData.isNotEmpty) {
      setState(() {
        brands = brandData;
        selectedBrand = brands.first['id'] ?? 0;
      });
    }

    if (categoryData.isNotEmpty) {
      setState(() {
        categories = categoryData;
        selectedCategory = categories.first['id'] ?? 0;
      });
    }
  }

  void _addVariant() {
    setState(() {
      variants.add({
        'name': '',
        'price': 0,
        'reseller_price': 0,
        'sku': '',
        'stock': 0,
        'weight': 0.0,
      });
    });
  }

  void _removeVariant(int index) {
    setState(() {
      variants.removeAt(index);
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final bloc = context.read<ProductBloc>();
      bloc.add(SubmitProductForm(
        productId: widget.product?['id'],
        name: nameController.text,
        description: descController.text,
        imageUrl: imageUrl,
        variants: variants,
      ));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ImageUploadSuccess) {
          setState(() {
            imageUrl = state.imageUrl;
          });
        } else if (state is ProductSubmissionSuccess) {
          context.go('/main/product');
        } else if (state is ProductError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.product == null ? 'Buat Produk Baru' : 'Edit Produks',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 128.0, vertical: 18.0),
              child: Column(
                children: [
                  // Nama dan Deskripsi Produk
                  ProductDetailSection(
                    nameController: nameController,
                    descController: descController,
                  ),
                  SizedBox(height: size.height * 0.02),

                  // Foto produk
                  ProductImageWidget(),
                  SizedBox(height: size.height * 0.02),

                  // Varian produk
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const FormLabel(label: 'Varian Produk'),
                              ElevatedButton(
                                onPressed: _addVariant,
                                child: Text('Tambah Varian'),
                              ),
                            ],
                          ),

                          // Variant List
                          ...variants.asMap().entries.map((entry) {
                            int index = entry.key;
                            Map<String, dynamic> variant = entry.value;

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: variant['name'],
                                      decoration: InputDecoration(
                                        labelText: 'Nama Varian',
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          variants[index]['name'] = value;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.01),
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: variant['sku'],
                                      decoration: InputDecoration(
                                        labelText: 'SKU Produk',
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          variants[index]['sku'] = value;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.01),
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: variant['price'].toString(),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Harga',
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          variants[index]['price'] =
                                              double.tryParse(value) ?? 0;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.01),
                                  Expanded(
                                    child: TextFormField(
                                      initialValue:
                                          variant['reseller_price'].toString(),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Harga Reseller',
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          variants[index]['reseller_price'] =
                                              double.tryParse(value) ?? 0;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.01),
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: variant['stock'].toString(),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Stok',
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          variants[index]['stock'] =
                                              double.tryParse(value) ?? 0;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.01),
                                  Expanded(
                                    child: TextFormField(
                                      initialValue:
                                          variant['weight'].toString(),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Berat (gr)',
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          variants[index]['weight'] =
                                              double.tryParse(value) ?? 0;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.01),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _removeVariant(index),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),

                  // Merek & Kategori produk
                  Row(
                    children: [
                      // Merek produk
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(18.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18.0,
                              vertical: 24.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Merek Produk
                                const FormLabel(label: 'Merek Produk'),
                                SizedBox(height: size.height * 0.01),
                                brands.isEmpty
                                    ? CircularProgressIndicator()
                                    : DropdownButtonFormField<int>(
                                        value: selectedBrand,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          hintText: 'Pilih Merek',
                                        ),
                                        items: brands.map((brand) {
                                          return DropdownMenuItem<int>(
                                            value: brand['id'],
                                            child: Text(brand['brand_name']),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedBrand = value;
                                          });
                                        },
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: size.height * 0.02),

                      // Kategori produk
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(18.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18.0,
                              vertical: 24.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const FormLabel(label: 'Kategori Produk'),
                                SizedBox(height: size.height * 0.01),
                                categories.isEmpty
                                    ? CircularProgressIndicator()
                                    : DropdownButtonFormField<int>(
                                        value: selectedCategory,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          hintText: 'Pilih Kategori',
                                        ),
                                        items: categories.map((categories) {
                                          return DropdownMenuItem<int>(
                                            value: categories['id'],
                                            child: Text(
                                                categories['category_name']),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedCategory = value;
                                          });
                                        },
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: Color(0xFFA67A4D),
              tooltip: 'Simpan produk',
              onPressed: () {
                _submitForm();
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
      ),
    );
  }
}
