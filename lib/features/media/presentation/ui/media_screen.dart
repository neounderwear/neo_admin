import 'package:flutter/material.dart';
import 'package:neo_admin/constant/widget/section_header.dart';
import 'package:neo_admin/features/media/presentation/widget/add_media_section.dart';
import 'package:neo_admin/features/media/presentation/widget/media_directory_section.dart';

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
                SizedBox(
                  height: 39.0,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(),
                    icon: const Icon(Icons.add),
                    label: const Text('Tambah Baru'),
                    onPressed: () {},
                  ),
                )
              ],
            ),
            const SizedBox(height: 12.0),
            const AddImageSection(),
            const SizedBox(height: 12.0),
            const MediaDirectorySection(),
          ],
        ),
      ),
    );
  }
}
