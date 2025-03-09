import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'package:neo_admin/constant/widget/form_label.dart';

class ProductVariantWidget extends StatefulWidget {
  final List<Map<String, dynamic>> initialVariants;
  final Function(List<Map<String, dynamic>>) onVariantChanged;

  const ProductVariantWidget({
    super.key,
    required this.initialVariants,
    required this.onVariantChanged,
  });

  @override
  State<ProductVariantWidget> createState() => _ProductVariantWidgetState();
}

class _ProductVariantWidgetState extends State<ProductVariantWidget> {
  late List<Map<String, dynamic>> variants;

  @override
  void initState() {
    super.initState();
    variants = List.from(widget.initialVariants);
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
    widget.onVariantChanged(variants);
  }

  void removeVariant(int index) {
    setState(() {
      variants.removeAt(index);
    });
    widget.onVariantChanged(variants);
  }

  void updateVariant(int index, String key, dynamic value) {
    setState(() {
      variants[index][key] = value;
    });
    widget.onVariantChanged(variants);
  }

  bool isSkuUnique(String sku, int currentIndex) {
    for (int i = 0; i < variants.length; i++) {
      if (i != currentIndex && variants[i]['sku'] == sku) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
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
                  onPressed: addVariant,
                  child: Text('Tambah Varian'),
                ),
              ],
            ),

            // Variant List
            variants.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Belum ada varian produk'),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: variants.length,
                    itemBuilder: (context, index) {
                      final variant = variants[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: variant['name'],
                                decoration: const InputDecoration(
                                  labelText: 'Nama Varian',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Nama varian wajib diisi';
                                  }
                                  return null;
                                },
                                onChanged: (value) =>
                                    updateVariant(index, 'name', value),
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'SKU wajib diisi';
                                  }
                                  if (!isSkuUnique(value, index)) {
                                    return 'SKU harus unik';
                                  }

                                  return null;
                                },
                                onChanged: (value) => updateVariant(
                                  index,
                                  'sku',
                                  value,
                                ),
                              ),
                            ),
                            SizedBox(width: size.width * 0.01),
                            Expanded(
                              child: TextFormField(
                                initialValue: variant['price'] == 0
                                    ? ''
                                    : variant['price'].toString(),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    labelText: 'Harga',
                                    border: OutlineInputBorder(),
                                    prefixText: 'Rp.'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Harga jual wajib diisi';
                                  }
                                  return null;
                                },
                                onChanged: (value) => updateVariant(
                                  index,
                                  'price',
                                  value.isEmpty ? 0 : int.parse(value),
                                ),
                              ),
                            ),
                            SizedBox(width: size.width * 0.01),
                            Expanded(
                              child: TextFormField(
                                initialValue: variant['discount_price'] == 0
                                    ? ''
                                    : variant['discount_price'].toString(),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    labelText: 'Harga Diskon',
                                    border: OutlineInputBorder(),
                                    prefixText: 'Rp.'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Harga diskon wajib diisi';
                                  }
                                  return null;
                                },
                                onChanged: (value) => updateVariant(
                                  index,
                                  'discount_price',
                                  value.isEmpty ? 0 : int.parse(value),
                                ),
                              ),
                            ),
                            SizedBox(width: size.width * 0.01),
                            Expanded(
                              child: TextFormField(
                                initialValue: variant['reseller_price'] == 0
                                    ? ''
                                    : variant['reseller_price'].toString(),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    labelText: 'Harga Reseller',
                                    border: OutlineInputBorder(),
                                    prefixText: 'Rp.'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Harga reseller wajib diisi';
                                  }
                                  return null;
                                },
                                onChanged: (value) => updateVariant(
                                  index,
                                  'reseller_price',
                                  value.isEmpty ? 0 : int.parse(value),
                                ),
                              ),
                            ),
                            SizedBox(width: size.width * 0.01),
                            Expanded(
                              child: TextFormField(
                                initialValue: variant['stock'] == 0
                                    ? ''
                                    : variant['stock'].toString(),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  labelText: 'Stok',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Stok wajib diisi';
                                  }
                                  return null;
                                },
                                onChanged: (value) => updateVariant(
                                  index,
                                  'stock',
                                  value.isEmpty ? 0 : int.parse(value),
                                ),
                              ),
                            ),
                            SizedBox(width: size.width * 0.01),
                            Expanded(
                              child: TextFormField(
                                initialValue: variant['weight'] == 0
                                    ? ''
                                    : variant['weight'].toString(),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  labelText: 'Berat (gr)',
                                  border: OutlineInputBorder(),
                                  suffixText: 'gr',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Stok wajib diisi';
                                  }
                                  return null;
                                },
                                onChanged: (value) => updateVariant(
                                  index,
                                  'weight',
                                  value.isEmpty ? 0 : int.parse(value),
                                ),
                              ),
                            ),
                            SizedBox(width: size.width * 0.01),
                            IconButton(
                              icon: Icon(IconlyBold.delete, color: Colors.red),
                              onPressed: () => removeVariant(index),
                            ),
                          ],
                        ),
                      );
                    },
                  )
          ],
        ),
      ),
    );
  }
}
