import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryService {
  final supabase = Supabase.instance.client;

  // Fungsi untuk fetch data kategori dari tabel categories
  Future<List<Map<String, dynamic>>> fetchCategories() async {
    final response = await supabase
        .from('categories')
        .select('*')
        .order('created_at', ascending: false);
    return response;
  }

  // Fungsi untuk menambah data kategori ke tabel categories
  Future<void> addCategories(String name, String imageUrl) async {
    await supabase
        .from('categories')
        .insert({'category_name': name, 'image_url': imageUrl});
  }

  // Fungsi untuk mengubah data kategori di tabel categories
  Future<void> updateCategories(
    String id,
    String name,
    Uint8List? imageBytes,
  ) async {
    try {
      final Map<String, dynamic> updateData = {'category_name': name};
      if (imageBytes != null) {
        final imageUrl = await uploadImage('/categories$id', imageBytes);
        updateData['image_url'] = imageUrl;
      }
      await supabase.from('categories').update(updateData).eq('id', id);
    } catch (e) {
      throw 'Gagal mengupdate kategori: ${e.toString()}';
    }
  }

  // Fungsi untuk menghapus data kategori dari tabel categories
  Future<void> deleteCategories(String id) async {
    await supabase.from('categories').delete().eq('id', id);
  }

  // Fungsi untuk mengupload gambar ke storage category-images
  Future<String> uploadImage(String pasth, Uint8List fileBytes) async {
    final fileName = '${DateTime.now().microsecondsSinceEpoch}.png';
    await supabase.storage
        .from('category-images')
        .uploadBinary(fileName, fileBytes);
    return supabase.storage.from('category-images').getPublicUrl(fileName);
  }
}
