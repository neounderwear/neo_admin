import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  final double? width;
  final double? height;
  final String data;
  final String label;

  const DataCard({
    super.key,
    required this.width,
    required this.height,
    required this.data,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              data,
              style: TextStyle(fontSize: 42),
            ),
            SizedBox(height: 8.0),
            Text(label),
          ],
        ),
      ),
    );
  }
}
