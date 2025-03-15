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
    // Pastikan selalu ada minimal satu varian saat inisialisasi
    if (variants.isEmpty) {
      variants.add(_createEmptyVariant());
    }
  }

  Map<String, dynamic> _createEmptyVariant() {
    return {
      'name': '',
      'sku': '',
      'price': 0,
      'discount_price': 0,
      'reseller_price': 0,
      'stock': 0,
      'weight': 0,
    };
  }

  void addVariant() {
    setState(() {
      variants.add(_createEmptyVariant());
    });
    widget.onVariantChanged(variants);
  }

  void removeVariant(int index) {
    setState(() {
      variants.removeAt(index);
      // Pastikan selalu ada minimal satu varian
      if (variants.isEmpty) {
        variants.add(_createEmptyVariant());
      }
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
                ElevatedButton.icon(
                  onPressed: addVariant,
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah Varian'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Variant List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: variants.length,
              itemBuilder: (context, index) {
                final variant = variants[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row 1: Name and SKU with Delete button
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name Field
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: TextField(
                                  controller: TextEditingController(
                                      text: variant['name']?.toString() ?? ''),
                                  decoration: const InputDecoration(
                                    labelText: 'Nama Varian',
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) =>
                                      updateVariant(index, 'name', value),
                                ),
                              ),
                            ),
                            // SKU Field
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: TextField(
                                  controller: TextEditingController(
                                      text: variant['sku']?.toString() ?? ''),
                                  decoration: const InputDecoration(
                                    labelText: 'SKU Produk',
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) =>
                                      updateVariant(index, 'sku', value),
                                ),
                              ),
                            ),
                            // Delete Button
                            IconButton(
                              icon: const Icon(IconlyBold.delete,
                                  color: Colors.red),
                              onPressed: () => removeVariant(index),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Row 2: Prices
                        Row(
                          children: [
                            // Regular Price
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: TextField(
                                  controller: TextEditingController(
                                    text: variant['price'] == 0
                                        ? ''
                                        : variant['price'].toString(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: 'Harga',
                                    prefixText: 'Rp.',
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) => updateVariant(
                                    index,
                                    'price',
                                    value.isEmpty ? 0 : int.parse(value),
                                  ),
                                ),
                              ),
                            ),
                            // Discount Price
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextField(
                                  controller: TextEditingController(
                                    text: variant['discount_price'] == 0
                                        ? ''
                                        : variant['discount_price'].toString(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: 'Harga Diskon',
                                    prefixText: 'Rp.',
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) => updateVariant(
                                    index,
                                    'discount_price',
                                    value.isEmpty ? 0 : int.parse(value),
                                  ),
                                ),
                              ),
                            ),
                            // Reseller Price
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextField(
                                  controller: TextEditingController(
                                    text: variant['reseller_price'] == 0
                                        ? ''
                                        : variant['reseller_price'].toString(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: 'Harga Reseller',
                                    prefixText: 'Rp.',
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) => updateVariant(
                                    index,
                                    'reseller_price',
                                    value.isEmpty ? 0 : int.parse(value),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Row 3: Stock and Weight
                        Row(
                          children: [
                            // Stock Field
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: TextField(
                                  controller: TextEditingController(
                                    text: variant['stock'] == 0
                                        ? ''
                                        : variant['stock'].toString(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: 'Stok',
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) => updateVariant(
                                    index,
                                    'stock',
                                    value.isEmpty ? 0 : int.parse(value),
                                  ),
                                ),
                              ),
                            ),
                            // Weight Field with suffix
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextField(
                                  controller: TextEditingController(
                                    text: variant['weight'] == 0
                                        ? ''
                                        : variant['weight'].toString(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: 'Berat',
                                    suffixText: 'gr',
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) => updateVariant(
                                    index,
                                    'weight',
                                    value.isEmpty ? 0 : int.parse(value),
                                  ),
                                ),
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
          ],
        ),
      ),
    );
  }
}
