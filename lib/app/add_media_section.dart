import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddImageSection extends StatelessWidget {
  const AddImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DottedBorder(
      color: Colors.grey,
      strokeWidth: 1.0,
      dashPattern: const [3, 2],
      borderType: BorderType.RRect,
      radius: const Radius.circular(12.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: size.height * 0.3,
          height: size.height * 0.3,
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
