// ignore_for_file: public_member_api_docs, sort_constructors_first
class DashboardData {
  final int bannerCount;
  final int categoryCount;
  final int brandCount;
  final int productCount;
  final int orderCount;
  final int customerCount;

  DashboardData({
    required this.bannerCount,
    required this.categoryCount,
    required this.brandCount,
    required this.productCount,
    required this.orderCount,
    required this.customerCount,
  });

  factory DashboardData.empty() {
    return DashboardData(
      bannerCount: 0,
      categoryCount: 0,
      brandCount: 0,
      productCount: 0,
      orderCount: 0,
      customerCount: 0,
    );
  }
}
