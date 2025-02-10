import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DataCard extends StatelessWidget {
  final double width;
  final double height;
  const DataCard({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: const Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitThreeBounce(
              color: Colors.orange,
              size: 20.0,
            ),
            SizedBox(height: 8.0),
            Text('Menampilkan Data'),
          ],
        ),
      ),
    );
  }
}
