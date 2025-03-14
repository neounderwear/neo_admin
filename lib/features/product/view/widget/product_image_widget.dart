import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:neo_admin/constant/widget/form_label.dart';

class ProductImageWidget extends StatefulWidget {
  final Uint8List? initialImageBytes;
  final String? initialImageUrl;
  final Function(Uint8List?)? onImageSelected;

  const ProductImageWidget({
    super.key,
    this.initialImageBytes,
    this.initialImageUrl,
    this.onImageSelected,
  });

  @override
  State<ProductImageWidget> createState() => _ProductImageWidgetState();
}

class _ProductImageWidgetState extends State<ProductImageWidget> {
  Uint8List? imageBytes;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    imageBytes = widget.initialImageBytes;
    imageUrl = widget.initialImageUrl;
  }

  Future<void> pickImage() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, withData: true);
    if (result != null) {
      setState(() {
        imageBytes = result.files.single.bytes;
      });
      if (widget.onImageSelected != null) {
        widget.onImageSelected!(imageBytes);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DottedBorder(
                  color: Colors.grey,
                  strokeWidth: 1.0,
                  dashPattern: const [3, 2],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12.0),
                  child: InkWell(
                    onTap: () {
                      pickImage();
                    },
                    child: Container(
                      width: size.height * 0.2,
                      height: size.height * 0.2,
                      decoration: const BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                      child: imageBytes != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child:
                                  Image.memory(imageBytes!, fit: BoxFit.cover),
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
              ],
            )
          ],
        ),
      ),
    );
  }
}
