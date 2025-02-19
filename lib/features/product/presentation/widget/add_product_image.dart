import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProductImage extends StatefulWidget {
  final double width;
  final double height;
  const AddProductImage({
    super.key,
    required this.width,
    required this.height,
  });
  @override
  State<AddProductImage> createState() => _AddProductImageState();
}

class _AddProductImageState extends State<AddProductImage> {
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colors.grey,
      strokeWidth: 1.0,
      dashPattern: const [3, 2],
      borderType: BorderType.RRect,
      radius: const Radius.circular(12.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: const BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_photo_alternate_rounded,
                size: 48.0,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
