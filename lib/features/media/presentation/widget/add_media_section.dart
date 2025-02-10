import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddImageSection extends StatelessWidget {
  const AddImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colors.grey,
      strokeWidth: 1.0,
      dashPattern: const [3, 2],
      borderType: BorderType.RRect,
      radius: const Radius.circular(18.0),
      child: Container(
        width: double.infinity,
        height: 200.0,
        decoration: const BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.all(
            Radius.circular(18.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add_photo_alternate_rounded,
                size: 48.0,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Tambah foto baru',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
