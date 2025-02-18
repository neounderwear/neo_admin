import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text('Tambah Produk'),
            SizedBox(
              height: 39.0,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Simpan'),
                onPressed: () {
                  context.go('/main/product');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
