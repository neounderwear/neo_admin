import 'package:neo_admin/features/dashboard/data/dashboard_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardService {
  final SupabaseClient supabase;

  DashboardService(this.supabase);

  Future<DashboardData> fetchDashboardData() async {
    try {
      final bannerCount = await _getTableCount('banners');
      final categoryCount = await _getTableCount('categories');
      final brandCount = await _getTableCount('brands');
      final productCount = await _getTableCount('products');
      final orderCount = await _getTableCount('orders');
      final customerCount = await _getTableCount('customers');

      return DashboardData(
        bannerCount: bannerCount,
        categoryCount: categoryCount,
        brandCount: brandCount,
        productCount: productCount,
        orderCount: orderCount,
        customerCount: customerCount,
      );
    } catch (e) {
      return DashboardData.empty();
    }
  }

  Future<int> _getTableCount(String tableName) async {
    try {
      final response = await supabase.from(tableName).count();
      return response;
    } catch (e) {
      return 0;
    }
  }
}
