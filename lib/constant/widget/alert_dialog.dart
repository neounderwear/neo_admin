import 'package:flutter/material.dart';
import 'package:neo_admin/constant/asset_manager.dart';

class AlertDialogSuccess extends StatelessWidget {
  final String label;
  final Function function;

  const AlertDialogSuccess({
    super.key,
    required this.label,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AssetManager.successIcon,
              height: 60.0,
            ),
            const SizedBox(height: 12.0),
            const Text(
              'Berhasil!',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              label,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: () {
                function();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40.0),
              ),
              child: const Text('Oke'),
            ),
          ],
        ),
      ),
    );
  }
}

class AlertDialogFailed extends StatelessWidget {
  final String label;
  final Function function;

  const AlertDialogFailed({
    super.key,
    required this.label,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AssetManager.failedIcon,
              height: 60.0,
            ),
            const SizedBox(height: 12.0),
            const Text(
              'Gagal!',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              label,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: () {
                function();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40.0),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Oke'),
            ),
          ],
        ),
      ),
    );
  }
}

class AlertDialogWarning extends StatelessWidget {
  final String label;
  final Function function;

  const AlertDialogWarning({
    super.key,
    required this.label,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AssetManager.warningIcon,
              height: 60.0,
            ),
            const SizedBox(height: 12.0),
            const Text(
              'Yakin?',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              label,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: () {
                function();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40.0),
              ),
              child: const Text('Oke'),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                side: BorderSide(color: Colors.brown),
                minimumSize: const Size(double.infinity, 40.0),
                backgroundColor: Colors.white,
                foregroundColor: Colors.brown,
              ),
              child: const Text('Batal'),
            ),
          ],
        ),
      ),
    );
  }
}
