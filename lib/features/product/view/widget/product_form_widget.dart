// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_admin/constant/asset_manager.dart';

import 'package:neo_admin/constant/widget/form_label.dart';
import 'package:neo_admin/features/product/data/product_model.dart';
import 'package:neo_admin/features/product/data/product_service.dart';
import 'package:neo_admin/features/product/view/widget/add_product_image.dart';
import 'package:neo_admin/features/product/view/widget/product_detail_section.dart';
import 'package:neo_admin/features/product/view/widget/product_single_type_section.dart';
import 'package:neo_admin/features/product/view/widget/product_type_section.dart';

// Widget halaman untuk menambah/mengubah produk
class ProductFormWidget extends StatefulWidget {
  final ProductService productService;
  final Product? product;

  const ProductFormWidget({
    super.key,
    required this.productService,
    this.product,
  });
  @override
  State<ProductFormWidget> createState() => _ProductFormWidgetState();
}

class _ProductFormWidgetState extends State<ProductFormWidget> {
  bool isSimpleProduct = true;
  String? selectedValue;
  String? selectedVariant;

  final formKey = GlobalKey<FormState>();
  Product product = Product(id: 0);

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      product = widget.product!;
    }
  }

  void saveProduct() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        if (product.id == 0) {
          await widget.productService.createProduct(product);
        } else {
          await widget.productService.updateProduct(product);
        }
      } catch (e) {
        DelightToastBar(
          builder: (context) {
            return ToastCard(
              leading: Image.asset(AssetManager.failedIcon),
              title: Text('Error: ${e.toString()}'),
              color: Color(0xFFD9C7B3),
            );
          },
          autoDismiss: true,
          position: DelightSnackbarPosition.top,
        ).show(context);
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
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      // Nama dan Deskripsi Produk
                      ProductDetailSection(
                        product: product,
                        onChanged: (updatedProduct) => setState(
                          () => product = updatedProduct,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      // Tipe Produk
                      ProductTypeSection(),
                      SizedBox(height: size.height * 0.02),
                      // IF type is Single
                      ProductSingleTypeSection(
                        product: product,
                        onChanged: (updatedProduct) => setState(
                          () => product = updatedProduct,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      // Container(
                      //   decoration: const BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: 18.0, vertical: 24.0),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Row(
                      //           children: [
                      //             Expanded(
                      //               flex: 1,
                      //               child: Column(
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                 children: [
                      //                   // Form Tipe Varian
                      //                   const FormLabel(label: 'Tipe Varian'),
                      //                   SizedBox(height: size.height * 0.01),
                      //                   SizedBox(
                      //                     height: size.height * 0.05,
                      //                     width: double.infinity,
                      //                     child: DecoratedBox(
                      //                       decoration: BoxDecoration(
                      //                         border: Border.all(
                      //                             color: Colors.grey,
                      //                             width: 1.0),
                      //                         borderRadius:
                      //                             BorderRadius.circular(8.0),
                      //                         color: Colors.white,
                      //                       ),
                      //                       child: Padding(
                      //                         padding:
                      //                             const EdgeInsets.symmetric(
                      //                                 horizontal: 8.0),
                      //                         child:
                      //                             DropdownButtonHideUnderline(
                      //                           child: DropdownButton<String>(
                      //                             value: selectedVariant,
                      //                             hint: const Text("Pilih"),
                      //                             onChanged:
                      //                                 (String? newValue) {
                      //                               setState(() {
                      //                                 selectedVariant =
                      //                                     newValue;
                      //                               });
                      //                             },
                      //                             items: [
                      //                               'Ukuran',
                      //                               'Warna',
                      //                             ].map((String value) {
                      //                               return DropdownMenuItem<
                      //                                   String>(
                      //                                 value: value,
                      //                                 child: Text(value),
                      //                               );
                      //                             }).toList(),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //             SizedBox(width: size.width * 0.01),
                      //             // Form Nama Varian
                      //             Expanded(
                      //               flex: 4,
                      //               child: Column(
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                 children: [
                      //                   const FormLabel(label: 'Varian'),
                      //                   SizedBox(height: size.height * 0.01),
                      //                   SizedBox(
                      //                     height: size.height * 0.05,
                      //                     child: TextFormField(
                      //                       keyboardType: TextInputType.text,
                      //                       textInputAction:
                      //                           TextInputAction.next,
                      //                       decoration: const InputDecoration(
                      //                         border: OutlineInputBorder(
                      //                           borderSide: BorderSide(),
                      //                           borderRadius: BorderRadius.all(
                      //                               Radius.circular(8.0)),
                      //                         ),
                      //                         hintText: 'Masukkan varian',
                      //                         hintStyle: TextStyle(
                      //                             color: Colors.grey,
                      //                             fontSize: 14.0),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         SizedBox(height: size.height * 0.02),
                      //         SizedBox(
                      //           height: size.height * 0.05,
                      //           child: ElevatedButton(
                      //             onPressed: () {},
                      //             child: Text('Tambah Varian'),
                      //           ),
                      //         ),
                      //         SizedBox(height: size.height * 0.03),
                      //         Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             const FormLabel(label: 'Putih, M'),
                      //             SizedBox(height: size.height * 0.01),
                      //             Row(
                      //               children: [
                      //                 Expanded(
                      //                   flex: 2,
                      //                   child: Column(
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.start,
                      //                     children: [
                      //                       const FormLabel(
                      //                           label: 'Harga Jual'),
                      //                       SizedBox(
                      //                           height: size.height * 0.01),
                      //                       SizedBox(
                      //                         height: size.height * 0.05,
                      //                         child: TextFormField(
                      //                           keyboardType:
                      //                               TextInputType.text,
                      //                           textInputAction:
                      //                               TextInputAction.next,
                      //                           decoration:
                      //                               const InputDecoration(
                      //                             border: OutlineInputBorder(
                      //                               borderSide: BorderSide(),
                      //                               borderRadius:
                      //                                   BorderRadius.all(
                      //                                       Radius.circular(
                      //                                           8.0)),
                      //                             ),
                      //                             hintText: 'Harga jual produk',
                      //                             hintStyle: TextStyle(
                      //                                 color: Colors.grey,
                      //                                 fontSize: 14.0),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 SizedBox(width: size.width * 0.01),
                      //                 Expanded(
                      //                   flex: 2,
                      //                   child: Column(
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.start,
                      //                     children: [
                      //                       const FormLabel(
                      //                           label: 'Harga Reseller'),
                      //                       SizedBox(
                      //                           height: size.height * 0.01),
                      //                       SizedBox(
                      //                         height: size.height * 0.05,
                      //                         child: TextFormField(
                      //                           keyboardType:
                      //                               TextInputType.text,
                      //                           textInputAction:
                      //                               TextInputAction.next,
                      //                           decoration:
                      //                               const InputDecoration(
                      //                             border: OutlineInputBorder(
                      //                               borderSide: BorderSide(),
                      //                               borderRadius:
                      //                                   BorderRadius.all(
                      //                                       Radius.circular(
                      //                                           8.0)),
                      //                             ),
                      //                             hintText: 'Harga reseller',
                      //                             hintStyle: TextStyle(
                      //                                 color: Colors.grey,
                      //                                 fontSize: 14.0),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 SizedBox(width: size.width * 0.01),
                      //                 Expanded(
                      //                   flex: 3,
                      //                   child: Column(
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.start,
                      //                     children: [
                      //                       const FormLabel(
                      //                           label: 'SKU Produk'),
                      //                       SizedBox(
                      //                           height: size.height * 0.01),
                      //                       SizedBox(
                      //                         height: size.height * 0.05,
                      //                         child: TextFormField(
                      //                           keyboardType:
                      //                               TextInputType.text,
                      //                           textInputAction:
                      //                               TextInputAction.next,
                      //                           decoration:
                      //                               const InputDecoration(
                      //                             border: OutlineInputBorder(
                      //                               borderSide: BorderSide(),
                      //                               borderRadius:
                      //                                   BorderRadius.all(
                      //                                       Radius.circular(
                      //                                           8.0)),
                      //                             ),
                      //                             hintText: 'SKU Produk',
                      //                             hintStyle: TextStyle(
                      //                                 color: Colors.grey,
                      //                                 fontSize: 14.0),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 SizedBox(width: size.width * 0.01),
                      //                 Expanded(
                      //                   flex: 1,
                      //                   child: Column(
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.start,
                      //                     children: [
                      //                       const FormLabel(label: 'Stok'),
                      //                       SizedBox(
                      //                           height: size.height * 0.01),
                      //                       SizedBox(
                      //                         height: size.height * 0.05,
                      //                         child: TextFormField(
                      //                           keyboardType:
                      //                               TextInputType.text,
                      //                           textInputAction:
                      //                               TextInputAction.next,
                      //                           decoration:
                      //                               const InputDecoration(
                      //                             border: OutlineInputBorder(
                      //                               borderSide: BorderSide(),
                      //                               borderRadius:
                      //                                   BorderRadius.all(
                      //                                       Radius.circular(
                      //                                           8.0)),
                      //                             ),
                      //                             hintText: 'Stok produk',
                      //                             hintStyle: TextStyle(
                      //                                 color: Colors.grey,
                      //                                 fontSize: 14.0),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 SizedBox(width: size.width * 0.01),
                      //                 Expanded(
                      //                   flex: 1,
                      //                   child: Column(
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.start,
                      //                     children: [
                      //                       const FormLabel(
                      //                           label: 'Berat (gr)'),
                      //                       SizedBox(
                      //                           height: size.height * 0.01),
                      //                       SizedBox(
                      //                         height: size.height * 0.05,
                      //                         child: TextFormField(
                      //                           keyboardType:
                      //                               TextInputType.text,
                      //                           textInputAction:
                      //                               TextInputAction.next,
                      //                           decoration:
                      //                               const InputDecoration(
                      //                             border: OutlineInputBorder(
                      //                               borderSide: BorderSide(),
                      //                               borderRadius:
                      //                                   BorderRadius.all(
                      //                                       Radius.circular(
                      //                                           8.0)),
                      //                             ),
                      //                             hintText: 'Berat produk',
                      //                             hintStyle: TextStyle(
                      //                                 color: Colors.grey,
                      //                                 fontSize: 14.0),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //             SizedBox(height: size.height * 0.02),
                      //             Divider(color: Colors.grey),
                      //             SizedBox(height: size.height * 0.02),
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(width: size.width * 0.01),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(18.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FormLabel(label: 'Foto Produk'),
                              SizedBox(height: size.height * 0.01),
                              AddProductImage(
                                  width: double.infinity,
                                  height: size.height * 0.3),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AddProductImage(
                                    width: size.height * 0.1,
                                    height: size.height * 0.1,
                                  ),
                                  AddProductImage(
                                    width: size.height * 0.1,
                                    height: size.height * 0.1,
                                  ),
                                  AddProductImage(
                                    width: size.height * 0.1,
                                    height: size.height * 0.1,
                                  ),
                                  AddProductImage(
                                    width: size.height * 0.1,
                                    height: size.height * 0.1,
                                  ),
                                  AddProductImage(
                                    width: size.height * 0.1,
                                    height: size.height * 0.1,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Container(
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
                              // Form Merek Produk
                              const FormLabel(label: 'Merek Produk'),
                              SizedBox(height: size.height * 0.01),
                              SizedBox(
                                height: size.height * 0.05,
                                width: double.infinity,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: selectedValue,
                                        hint: const Text("Pilih"),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedValue = newValue;
                                          });
                                        },
                                        items: [
                                          '777',
                                          'Pierre Cardin',
                                          'Rider',
                                        ].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Container(
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
                              // Form Kategori Produk
                              const FormLabel(label: 'Kategori Produk'),
                              SizedBox(height: size.height * 0.01),
                              SizedBox(
                                height: size.height * 0.05,
                                width: double.infinity,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: selectedValue,
                                        hint: const Text("Pilih"),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedValue = newValue;
                                          });
                                        },
                                        items: [
                                          'Pria',
                                          'Wanita',
                                          'Anak-anak',
                                        ].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Container(
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
                              // Tipe Produk
                              const FormLabel(label: 'Status Produk'),
                              SizedBox(height: size.height * 0.01),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isSimpleProduct = true;
                                          });
                                        },
                                        icon: Icon(
                                          isSimpleProduct
                                              ? Icons
                                                  .radio_button_checked_rounded
                                              : Icons
                                                  .radio_button_unchecked_rounded,
                                          color: isSimpleProduct
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey,
                                        ),
                                      ),
                                      const Text('Aktif'),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isSimpleProduct = false;
                                          });
                                        },
                                        icon: Icon(
                                          !isSimpleProduct
                                              ? Icons
                                                  .radio_button_checked_rounded
                                              : Icons
                                                  .radio_button_unchecked_rounded,
                                          color: !isSimpleProduct
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey,
                                        ),
                                      ),
                                      const Text('Tidak Aktif'),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
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
  }
}
