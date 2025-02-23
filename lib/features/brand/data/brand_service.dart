import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

class BrandService {
  final supabase = Supabase.instance.client;

  // Fungsi untuk fetch data merek dari tabel brands
  Future<List<Map<String, dynamic>>> fetchBrands() async {
    final response = await supabase
        .from('brands')
        .select('*')
        .order('created_at', ascending: false);
    return response;
  }

  // Fungsi untuk menambah data merek ke tabel brands
  Future<void> addBrands(String name, String imageUrl) async {
    await supabase
        .from('brands')
        .insert({'brand_name': name, 'image_url': imageUrl});
  }

  // Fungsi untuk mengubah merek di tabel brands
  Future<void> updateBrands(
      String id, String name, Uint8List? imageBytes) async {
    try {
      final Map<String, dynamic> updateData = {'brand_name': name};
      if (imageBytes != null) {
        final imageUrl = await uploadImage('/brands$id', imageBytes);
        updateData['image_url'] = imageUrl;
      }

      await supabase.from('brands').update(updateData).eq('id', id);
    } catch (e) {
      throw 'Gagal mengupdate merek: ${e.toString()}';
    }
  }

  // Fungsi untuk menghapus data merek dari tabel brands
  Future<void> deleteBrands(String id) async {
    await supabase.from('brands').delete().eq('id', id);
  }

  // Fungsi untuk mengupload gambar ke storage brand-images
  Future<String> uploadImage(String path, Uint8List fileBytes) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
    await supabase.storage
        .from('brand-images')
        .uploadBinary(fileName, fileBytes);
    return supabase.storage.from('brand-images').getPublicUrl(fileName);
  }
}
