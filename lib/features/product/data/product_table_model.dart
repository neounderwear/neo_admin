class ProductTableModel {
  final String imageUrl;
  final String productName;
  final String productPrice;
  final String productQty;
  final String productOrdered;
  final bool productStatus;

  ProductTableModel({
    required this.imageUrl,
    required this.productName,
    required this.productPrice,
    required this.productQty,
    required this.productOrdered,
    required this.productStatus,
  });
}
