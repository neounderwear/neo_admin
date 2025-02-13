import 'package:flutter/material.dart';

class DeleteBrandWidget extends StatefulWidget {
  const DeleteBrandWidget({super.key});

  @override
  State<DeleteBrandWidget> createState() => _DeleteBrandWidgetState();
}

class _DeleteBrandWidgetState extends State<DeleteBrandWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Hapus Merek?'),
      content: const Text('Merek bakalan dihapus permanen'),
      actions: [
        TextButton(
          child: const Text('Batal'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text(
            'Hapus',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
