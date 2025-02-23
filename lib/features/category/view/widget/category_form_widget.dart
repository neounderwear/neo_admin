import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_admin/features/category/bloc/category_bloc.dart';
import 'package:neo_admin/features/category/bloc/category_event.dart';

class CategoryFormWidget extends StatefulWidget {
  final Map<String, dynamic>? category;
  const CategoryFormWidget({super.key, this.category});

  @override
  State<CategoryFormWidget> createState() => _CategoryFormWidgetState();
}

class _CategoryFormWidgetState extends State<CategoryFormWidget> {
  final nameController = TextEditingController();
  Uint8List? imageBytes;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      nameController.text = widget.category!['category_name'] ?? '';
      imageUrl = widget.category!['image_url'] ?? '';
    }
  }

  // Fungsi untuk memilih gambar dari device
  Future<void> pickImage() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, withData: true);
    if (result != null) {
      setState(() {
        imageBytes = result.files.single.bytes;
      });
    }
  }

  // Fungsi untuk mengirim data
  void submit() {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama tidak boleh kosong')),
      );
      return;
    }

    if (widget.category == null && imageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logo tidak boleh kosong')),
      );
      return;
    }

    final bloc = context.read<CategoryBloc>();
    try {
      if (widget.category == null) {
        bloc.add(AddCategories(nameController.text, imageBytes!));
      } else {
        bloc.add(UpdateCategories(
          widget.category!['id'].toString(),
          nameController.text,
          imageBytes,
        ));
      }
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: size.width * 0.2,
          minWidth: size.width * 0.2,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DottedBorder(
                color: Colors.grey,
                strokeWidth: 1.0,
                dashPattern: const [3, 2],
                borderType: BorderType.RRect,
                radius: const Radius.circular(12.0),
                child: InkWell(
                  onTap: pickImage,
                  child: Container(
                    width: size.height * 0.3,
                    height: size.height * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: imageBytes != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.memory(imageBytes!, fit: BoxFit.cover),
                          )
                        : (imageUrl != null && imageUrl!.isNotEmpty)
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.network(
                                  imageUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Icon(
                                        Icons.error_outline,
                                        size: 48.0,
                                        color: Colors.grey,
                                      ),
                                    );
                                  },
                                ),
                              )
                            : const Center(
                                child: Icon(
                                  Icons.add_photo_alternate_rounded,
                                  size: 48.0,
                                  color: Colors.grey,
                                ),
                              ),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Nama Kategori', style: TextStyle(fontSize: 14.0)),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Batal'),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: submit,
                      child:
                          Text(widget.category == null ? 'Tambah' : 'Simpan'),
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
