import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

class BannerService {
  final supabase = Supabase.instance.client;

  // Fungsi untuk fetch data banner dari tabel banners
  Future<List<Map<String, dynamic>>> fetchBanners() async {
    final response = await supabase
        .from('banners')
        .select('*')
        .order('created_at', ascending: false);
    return response;
  }

  // Fungsi untuk menambah banner ke tabel banners
  Future<void> addBanners(String page, String imageUrl, bool isActive) async {
    await supabase.from('banners').insert({
      'page': page,
      'image_url': imageUrl,
      'is_active': isActive,
    });
  }

  // Fungsi untuk mengubah banner di tabel banners
  Future<void> updateBanner(
    String id,
    String page,
    bool isActive,
    Uint8List? imageBytes,
  ) async {
    try {
      final Map<String, dynamic> updateData = {
        'page': page,
        'is_active': isActive
      };
      if (imageBytes != null) {
        final imageUrl = await uploadImage('/banners$id', imageBytes);
        updateData['image_url'] = imageUrl;
      }

      await supabase.from('banners').update(updateData).eq('id', id);
    } catch (e) {
      throw 'Gagal mengupdate banner: \${e.toString()}';
    }
  }

  // Fungsi untuk menghapus banner dari tabel banners
  Future<void> deleteBanners(String id) async {
    await supabase.from('banners').delete().eq('id', id);
  }

  // Fungsi untuk mengupload gambar ke storage banner-images
  Future<String> uploadImage(String pasth, Uint8List fileBytes) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
    await supabase.storage
        .from('banner-images')
        .uploadBinary(fileName, fileBytes);
    return supabase.storage.from('banner-images').getPublicUrl(fileName);
  }
}
