import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:neo_admin/constant/color.dart';
import 'package:neo_admin/constant/widget/alert_dialog.dart';
import 'package:neo_admin/features/product/bloc/product_bloc.dart';
import 'package:neo_admin/features/product/bloc/product_event.dart';
import 'package:neo_admin/features/product/bloc/product_state.dart';

// Widget untuk menampilkan daftar produk
// dalam bentuk tabel
class ProductTableWidget extends StatefulWidget {
  // Add callback for editing a product
  final Function(Map<String, dynamic>)? onEditProduct;

  const ProductTableWidget({super.key, this.onEditProduct});

  @override
  State<ProductTableWidget> createState() => _ProductTableWidgetState();
}

class _ProductTableWidgetState extends State<ProductTableWidget> {
  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProducts());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      if (state is ProductLoading) {
        return Center(
          child: SpinKitThreeBounce(
            color: Colors.brown,
            size: 36.0,
          ),
        );
      } else if (state is ProductError) {
        return Center(child: Text('Error: ${state.message}'));
      } else {
        final products = BlocProvider.of<ProductBloc>(context).products;

        if (products.isEmpty) {
          return const Center(
            child: Text('Kamu belum menambahkan produk. Tambah sekarang'),
          );
        }

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DataTable(
            columnSpacing: 16,
            dataRowMinHeight: 80,
            dataRowMaxHeight: 100,
            border: TableBorder.all(color: Colors.grey.shade300),
            headingRowColor: WidgetStateProperty.all(AppColor.secondaryColor),
            headingTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            columns: const <DataColumn>[
              DataColumn(
                headingRowAlignment: MainAxisAlignment.center,
                label: Text('Produk'),
              ),
              DataColumn(
                headingRowAlignment: MainAxisAlignment.center,
                label: Text('Harga'),
              ),
              DataColumn(
                headingRowAlignment: MainAxisAlignment.center,
                label: Text('Harga Reseller'),
              ),
              DataColumn(
                headingRowAlignment: MainAxisAlignment.center,
                label: Text('Stok'),
              ),
              DataColumn(
                headingRowAlignment: MainAxisAlignment.center,
                label: Text('Penjualan'),
              ),
              DataColumn(
                headingRowAlignment: MainAxisAlignment.center,
                label: Text('Atur'),
              ),
            ],
            rows: products.map((product) {
              double minPrice = double.infinity;
              double maxPrice = 0;
              int totalStock = 0;

              List<dynamic> variants = product['product_variants'] ?? [];

              if (variants.isNotEmpty) {
                for (var variant in variants) {
                  if (variant['price'] < minPrice) {
                    minPrice = variant['price'].toDouble();
                  }

                  if (variant['price'] > maxPrice) {
                    maxPrice = variant['price'].toDouble();
                  }

                  // More explicit conversion handling different possible types
                  if (variant['stock'] != null) {
                    if (variant['stock'] is int) {
                      totalStock += variant['stock'] as int;
                    } else if (variant['stock'] is double) {
                      totalStock += (variant['stock'] as double).toInt();
                    } else {
                      // If it's a String or other type, try to parse it
                      try {
                        totalStock += int.parse(variant['stock'].toString());
                      } catch (e) {
                        rethrow;
                      }
                    }
                  }
                }
              } else {
                minPrice = 0;
                maxPrice = 0;
              }

              String priceText = minPrice == maxPrice
                  ? currencyFormatter.format(minPrice)
                  : '${currencyFormatter.format(minPrice)} - ${currencyFormatter.format(maxPrice)}';

              if (minPrice == double.infinity) {
                priceText = 'Rp 0';
              }

              return DataRow(
                cells: <DataCell>[
                  DataCell(
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: product['image_url'] != null
                                ? Image.network(
                                    product['image_url'],
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.broken_image,
                                          size: 50);
                                    },
                                  )
                                : Container(
                                    width: 60,
                                    height: 60,
                                    color: Colors.grey[300],
                                    child:
                                        const Icon(Icons.image_not_supported),
                                  ),
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        Text(product['name']),
                      ],
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Harga asli yang dicoret (strikethrough)
                          Text(
                            priceText,
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          // Harga diskon
                          Builder(
                            builder: (context) {
                              // Hitung rentang harga diskon
                              double minDiscountPrice = double.infinity;
                              double maxDiscountPrice = 0;
                              bool hasDiscount = false;

                              if (variants.isNotEmpty) {
                                for (var variant in variants) {
                                  if (variant['discount_price'] != null &&
                                      variant['discount_price'] > 0) {
                                    hasDiscount = true;
                                    double discountPrice =
                                        variant['discount_price'].toDouble();

                                    if (discountPrice < minDiscountPrice) {
                                      minDiscountPrice = discountPrice;
                                    }

                                    if (discountPrice > maxDiscountPrice) {
                                      maxDiscountPrice = discountPrice;
                                    }
                                  }
                                }
                              }

                              // Tampilkan harga diskon
                              if (hasDiscount) {
                                String discountPriceText = minDiscountPrice ==
                                        maxDiscountPrice
                                    ? currencyFormatter.format(minDiscountPrice)
                                    : '${currencyFormatter.format(minDiscountPrice)} - ${currencyFormatter.format(maxDiscountPrice)}';

                                return Text(
                                  discountPriceText,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[700],
                                  ),
                                );
                              } else {
                                return Text(
                                  'Tidak ada diskon',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[600],
                                    fontStyle: FontStyle.italic,
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Builder(
                        builder: (context) {
                          // Hitung rentang harga reseller
                          double minResellerPrice = double.infinity;
                          double maxResellerPrice = 0;
                          bool hasResellerPrice = false;

                          if (variants.isNotEmpty) {
                            for (var variant in variants) {
                              if (variant['reseller_price'] != null &&
                                  variant['reseller_price'] > 0) {
                                hasResellerPrice = true;
                                double resellerPrice =
                                    variant['reseller_price'].toDouble();

                                if (resellerPrice < minResellerPrice) {
                                  minResellerPrice = resellerPrice;
                                }

                                if (resellerPrice > maxResellerPrice) {
                                  maxResellerPrice = resellerPrice;
                                }
                              }
                            }
                          }

                          // Tampilkan harga reseller
                          if (hasResellerPrice) {
                            String resellerPriceText = minResellerPrice ==
                                    maxResellerPrice
                                ? currencyFormatter.format(minResellerPrice)
                                : '${currencyFormatter.format(minResellerPrice)} - ${currencyFormatter.format(maxResellerPrice)}';

                            return Text(resellerPriceText);
                          } else {
                            return Text(
                              'Tidak ada harga reseller',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                                fontStyle: FontStyle.italic,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  DataCell(
                    Center(child: Text(totalStock.toString())),
                  ),
                  DataCell(Center(child: Text('0'))),
                  // Modified action cell to use modal instead of navigation
                  DataCell(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(IconlyBold.edit, size: 18.0),
                          onPressed: () {
                            // Using the callback to show modal bottom sheet
                            if (widget.onEditProduct != null) {
                              final productData =
                                  Map<String, dynamic>.from(product);
                              widget.onEditProduct!(productData);
                            } else {
                              // Show error if callback is missing
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Tidak dapat mengedit produk',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  duration: Duration(seconds: 2),
                                  behavior: SnackBarBehavior.fixed,
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(IconlyBold.delete,
                              size: 18, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) =>
                                  AlertDialogWarning(
                                label: 'Produk bakalan dihapus permanen',
                                function: () {
                                  // Pastikan ID produk tersedia
                                  if (product['id'] != null) {
                                    BlocProvider.of<ProductBloc>(context).add(
                                      DeleteProducts(product['id']),
                                    );
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Berhasil menghapus produk',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        duration: Duration(seconds: 2),
                                        behavior: SnackBarBehavior.fixed,
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  } else {
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'ID produk tidak valid',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        duration: Duration(seconds: 2),
                                        behavior: SnackBarBehavior.fixed,
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              );
            }).toList(),
          ),
        );
      }
    });
  }
}
