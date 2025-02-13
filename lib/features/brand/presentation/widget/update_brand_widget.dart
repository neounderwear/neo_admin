import 'package:flutter/material.dart';
import 'package:neo_admin/app/add_media_section.dart';

class UpdateBrandWidget extends StatefulWidget {
  const UpdateBrandWidget({super.key});

  @override
  State<UpdateBrandWidget> createState() => _UpdateBrandWidgetState();
}

class _UpdateBrandWidgetState extends State<UpdateBrandWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: size.width * 0.2, minWidth: size.width * 0.2),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 36.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AddImageSection(),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Nama Merek',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: SizedBox(
                      height: 40.0,
                      child: TextField(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Batal'),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: TAMBAHKAN FUNGSI UNTUK MENYIMPAN PERUBAHAN MEREK
                      },
                      child: const Text('Simpan'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
