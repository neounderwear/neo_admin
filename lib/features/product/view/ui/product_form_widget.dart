import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_admin/constant/widget/form_label.dart';
import 'package:neo_admin/features/product/view/widget/add_product_image.dart';

class ProductFormWidget extends StatefulWidget {
  const ProductFormWidget({super.key});
  @override
  State<ProductFormWidget> createState() => _ProductFormWidgetState();
}

class _ProductFormWidgetState extends State<ProductFormWidget> {
  bool isSimpleProduct = true;
  String? selectedValue;
  String? selectedVariant;
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
                            // Form Nama Produk
                            const FormLabel(label: 'Nama Produk'),
                            SizedBox(height: size.height * 0.01),
                            SizedBox(
                              height: size.height * 0.05,
                              child: TextFormField(
                                // controller: // TODO: Add name controller
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                  ),
                                  hintText: 'Nama Produk',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            // Form Deskripsi Produk
                            const FormLabel(label: 'Deskripsi Produk'),
                            SizedBox(height: size.height * 0.01),
                            TextFormField(
                              // controller: // TODO: Add description controller
                              keyboardType: TextInputType.multiline,
                              maxLines: 10,
                              textInputAction: TextInputAction.newline,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                                hintText: 'Deskripsi Produk',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
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
                            const FormLabel(label: 'Tipe Produk'),
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
                                            ? Icons.radio_button_checked_rounded
                                            : Icons
                                                .radio_button_unchecked_rounded,
                                        color: isSimpleProduct
                                            ? Theme.of(context).primaryColor
                                            : Colors.grey,
                                      ),
                                    ),
                                    const Text('Tanpa Varian'),
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
                                            ? Icons.radio_button_checked_rounded
                                            : Icons
                                                .radio_button_unchecked_rounded,
                                        color: !isSimpleProduct
                                            ? Theme.of(context).primaryColor
                                            : Colors.grey,
                                      ),
                                    ),
                                    const Text('Dengan Varian'),
                                  ],
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
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Form Harga Produk
                                      const FormLabel(label: 'Harga Jual'),
                                      SizedBox(height: size.height * 0.01),
                                      SizedBox(
                                        height: size.height * 0.05,
                                        child: TextFormField(
                                          // controller: priceController,
                                          keyboardType: TextInputType.number,
                                          textInputAction: TextInputAction.next,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8.0),
                                              ),
                                            ),
                                            prefixText: 'Rp ',
                                            prefixStyle:
                                                TextStyle(color: Colors.black),
                                            hintText: 'Harga Jual',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Form Harga Reseller
                                      const FormLabel(label: 'Harga Reseller'),
                                      SizedBox(height: size.height * 0.01),
                                      SizedBox(
                                        height: size.height * 0.05,
                                        child: TextFormField(
                                          // controller: priceController,
                                          keyboardType: TextInputType.number,
                                          textInputAction: TextInputAction.next,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8.0),
                                              ),
                                            ),
                                            prefixText: 'Rp ',
                                            prefixStyle:
                                                TextStyle(color: Colors.black),
                                            hintText: 'Harga Reseller',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.02),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Form SKU Produk
                                      const FormLabel(label: 'SKU Produk'),
                                      SizedBox(height: size.height * 0.01),
                                      SizedBox(
                                        height: size.height * 0.05,
                                        child: TextFormField(
                                          // controller: stockController,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8.0),
                                              ),
                                            ),
                                            hintText: 'Masukkan SKU produk',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Form Stok Produk
                                      const FormLabel(label: 'Stok Produk'),
                                      SizedBox(height: size.height * 0.01),
                                      SizedBox(
                                        height: size.height * 0.05,
                                        child: TextFormField(
                                          // controller: stockController,
                                          keyboardType: TextInputType.number,
                                          textInputAction: TextInputAction.next,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8.0),
                                              ),
                                            ),
                                            hintText: 'Jumlah Stok',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Form Berat Produk
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const FormLabel(
                                        label: 'Berat Produk (gr)',
                                      ),
                                      SizedBox(height: size.height * 0.01),
                                      SizedBox(
                                        height: size.height * 0.05,
                                        child: TextFormField(
                                          // controller: weightController,
                                          keyboardType: TextInputType.number,
                                          textInputAction: TextInputAction.next,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8.0),
                                              ),
                                            ),
                                            hintText: 'Berat Produk',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Form Tipe Varian
                                      const FormLabel(label: 'Tipe Varian'),
                                      SizedBox(height: size.height * 0.01),
                                      SizedBox(
                                        height: size.height * 0.05,
                                        width: double.infinity,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                value: selectedVariant,
                                                hint: const Text("Pilih"),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    selectedVariant = newValue;
                                                  });
                                                },
                                                items: [
                                                  'Ukuran',
                                                  'Warna',
                                                ].map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
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
                                SizedBox(width: size.width * 0.01),
                                // Form Nama Varian
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const FormLabel(label: 'Varian'),
                                      SizedBox(height: size.height * 0.01),
                                      SizedBox(
                                        height: size.height * 0.05,
                                        child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0)),
                                            ),
                                            hintText: 'Masukkan varian',
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.02),
                            SizedBox(
                              height: size.height * 0.05,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text('Tambah Varian'),
                              ),
                            ),
                            SizedBox(height: size.height * 0.03),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const FormLabel(label: 'Putih, M'),
                                SizedBox(height: size.height * 0.01),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const FormLabel(label: 'Harga Jual'),
                                          SizedBox(height: size.height * 0.01),
                                          SizedBox(
                                            height: size.height * 0.05,
                                            child: TextFormField(
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8.0)),
                                                ),
                                                hintText: 'Harga jual produk',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: size.width * 0.01),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const FormLabel(
                                              label: 'Harga Reseller'),
                                          SizedBox(height: size.height * 0.01),
                                          SizedBox(
                                            height: size.height * 0.05,
                                            child: TextFormField(
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8.0)),
                                                ),
                                                hintText: 'Harga reseller',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: size.width * 0.01),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const FormLabel(label: 'SKU Produk'),
                                          SizedBox(height: size.height * 0.01),
                                          SizedBox(
                                            height: size.height * 0.05,
                                            child: TextFormField(
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8.0)),
                                                ),
                                                hintText: 'SKU Produk',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: size.width * 0.01),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const FormLabel(label: 'Stok'),
                                          SizedBox(height: size.height * 0.01),
                                          SizedBox(
                                            height: size.height * 0.05,
                                            child: TextFormField(
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8.0)),
                                                ),
                                                hintText: 'Stok produk',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: size.width * 0.01),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const FormLabel(label: 'Berat (gr)'),
                                          SizedBox(height: size.height * 0.01),
                                          SizedBox(
                                            height: size.height * 0.05,
                                            child: TextFormField(
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8.0)),
                                                ),
                                                hintText: 'Berat produk',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.02),
                                Divider(color: Colors.grey),
                                SizedBox(height: size.height * 0.02),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            ? Icons.radio_button_checked_rounded
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
                                            ? Icons.radio_button_checked_rounded
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
    );
  }
}
