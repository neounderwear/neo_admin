import 'package:flutter/material.dart';
import 'package:neo_admin/constant/widget/section_header.dart';
import 'package:neo_admin/features/media/presentation/widget/add_media.dart';

class MediaScreen extends StatelessWidget {
  static const routeName = '/media';
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SectionHeader(text: 'Media'),
                Row(
                  children: [
                    const SizedBox(
                      width: 500,
                      height: 40.0,
                      child: TextField(
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: 'Cari apa...',
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    SizedBox(
                      height: 39.0,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        icon: const Icon(Icons.add),
                        label: const Text('Tambah Baru'),
                        onPressed: () {},
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 12.0),
            const AddImageSection(),
            const SizedBox(height: 12.0),

            // SOLUSI: Bungkus Container dengan Expanded agar fleksibel
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(18.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Direktori',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        const SizedBox(width: 24.0),
                        DropdownButton(
                          items: const [
                            DropdownMenuItem(
                                value: "Merek", child: Text('Merek')),
                            DropdownMenuItem(
                                value: "Kategori", child: Text('Kategori')),
                            DropdownMenuItem(
                                value: "Banner", child: Text('Banner')),
                          ],
                          onChanged: (value) {},
                        )
                      ],
                    ),
                    const SizedBox(height: 12.0),

                    // SOLUSI: Gunakan Expanded agar GridView tidak overflow
                    GridView.builder(
                      shrinkWrap:
                          true, // Agar tinggi GridView mengikuti jumlah item
                      physics:
                          const NeverScrollableScrollPhysics(), // Mencegah scroll
                      itemCount: 10, // Sesuaikan dengan jumlah item
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 8,
                        childAspectRatio: 1, // Sesuaikan ukuran kotak
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) => const SizedBox(
                        height: 200.0,
                        width: 200.0,
                        child: Card(color: Colors.orange),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
