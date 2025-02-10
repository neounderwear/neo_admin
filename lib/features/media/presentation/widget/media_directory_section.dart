import 'package:flutter/material.dart';

class MediaDirectorySection extends StatefulWidget {
  const MediaDirectorySection({super.key});

  @override
  State<MediaDirectorySection> createState() => _MediaDirectorySectionState();
}

class _MediaDirectorySectionState extends State<MediaDirectorySection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
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
                    DropdownMenuItem(value: "Merek", child: Text('Merek')),
                    DropdownMenuItem(
                        value: "Kategori", child: Text('Kategori')),
                    DropdownMenuItem(value: "Banner", child: Text('Banner')),
                  ],
                  onChanged: (value) {},
                )
              ],
            ),
            const SizedBox(height: 12.0),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) => const SizedBox(
                height: 200.0,
                width: 200.0,
                child: Card(color: Colors.brown),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
