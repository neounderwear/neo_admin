import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardService {
  final supabase = Supabase.instance.client;

  // Banner
  Future<int> fetchBannerCount() async {
    try {
      final count = await supabase.from('banners').count();
      return count;
    } catch (e) {
      return 0;
    }
  }

  // Category
  Future<int> fetchCategoryCount() async {
    try {
      final count = await supabase.from('categories').count();
      return count;
    } catch (e) {
      return 0;
    }
  }

  // Brand
  Future<int> fetchBrandCount() async {
    try {
      final count = await supabase.from('brands').count();
      return count;
    } catch (e) {
      return 0;
    }
  }

  // Product
  Future<int> fetchProductCount() async {
    try {
      final count = await supabase.from('products').count();
      return count;
    } catch (e) {
      return 0;
    }
  }
}
