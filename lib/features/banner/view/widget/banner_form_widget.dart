import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_admin/features/banner/bloc/banner_bloc.dart';
import 'package:neo_admin/features/banner/bloc/banner_event.dart';

// Widget pop-up untuk menambah/mengubah banner
class BannerFormWidget extends StatefulWidget {
  final Map<String, dynamic>? banner;
  const BannerFormWidget({super.key, this.banner});

  @override
  State<BannerFormWidget> createState() => _BannerFormWidgetState();
}

class _BannerFormWidgetState extends State<BannerFormWidget> {
  bool isActive = true;
  String? selectedPage;
  Uint8List? imageBytes;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    if (widget.banner != null) {
      selectedPage = widget.banner!['page'];
      isActive = widget.banner!['isActive'] ?? true;
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
    if (selectedPage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Silakan pilih halaman untuk banner',
            style: TextStyle(color: Colors.black),
          ),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.yellow,
          width: 300.0,
        ),
      );
    }

    if (widget.banner == null && imageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Banner tidak boleh kosong',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.yellow,
          width: 300.0,
        ),
      );
    }

    final bloc = context.read<BannerBloc>();
    try {
      if (widget.banner == null) {
        bloc.add(AddBanners(
          selectedPage!,
          isActive,
          imageBytes!,
        ));
      } else {
        bloc.add(UpdateBanners(
          widget.banner!['id'].toString(),
          selectedPage!,
          isActive,
          imageBytes,
        ));
      }
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error: ${e.toString()}',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          width: 300.0,
        ),
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
            maxWidth: size.width * 0.2, minWidth: size.width * 0.2),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 36.0,
          ),
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
                  const Text('Pilih Halaman', style: TextStyle(fontSize: 14.0)),
                  const SizedBox(width: 16.0),
                  SizedBox(
                    height: 30.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedPage,
                            hint: const Text("Pilih"),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedPage = newValue;
                              });
                            },
                            items: ['Beranda', 'Promo', 'Produk', 'Informasi']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                      value: isActive,
                      onChanged: (bool? value) {
                        setState(() {
                          isActive = value ?? true;
                        });
                      }),
                  Text(
                    'Tandai Aktif',
                    style: TextStyle(fontSize: 14.0),
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
                        side: BorderSide(color: Colors.brown),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.brown,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Batal'),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        submit();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              widget.banner == null
                                  ? 'Berhasil upload merek'
                                  : 'Berhasil menyimpan',
                              style: TextStyle(color: Colors.white),
                            ),
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.green,
                            width: 300.0,
                          ),
                        );
                      },
                      child: Text(widget.banner == null ? 'Tambah' : 'Simpan'),
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
