// product.dart
class Product {
  final int? id;
  final String? productName;
  final String? productDesc;
  final String? productThumb;
  final int? brandId;
  final int? categoryId;
  final String? productType;
  final double? retailPrice;
  final double? resellerPrice;
  final int? productStock;
  final bool? productStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<ProductVariant>? variants;
  final List<ProductVariantOption>? variantOptions;
  final List<ProductImage>? images;

  Product({
    this.id,
    this.productName,
    this.productDesc,
    this.productThumb,
    this.brandId,
    this.categoryId,
    this.productType,
    this.retailPrice,
    this.resellerPrice,
    this.productStock,
    this.productStatus,
    this.createdAt,
    this.updatedAt,
    this.variants,
    this.variantOptions,
    this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      productName: json['product_name'],
      productDesc: json['product_desc'],
      productThumb: json['product_thumb'],
      brandId: json['brand_id'],
      categoryId: json['category_id'],
      productType: json['product_type'],
      retailPrice: json['retail_price'] != null
          ? double.parse(json['retail_price'].toString())
          : null,
      resellerPrice: json['reseller_price'] != null
          ? double.parse(json['reseller_price'].toString())
          : null,
      productStock: json['product_stock'],
      productStatus: json['product_status'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_name': productName,
      'product_desc': productDesc,
      'product_thumb': productThumb,
      'brand_id': brandId,
      'category_id': categoryId,
      'product_type': productType,
      'retail_price': retailPrice,
      'reseller_price': resellerPrice,
      'product_stock': productStock,
      'product_status': productStatus,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Product copyWith({
    int? id,
    String? productName,
    String? productDesc,
    String? productThumb,
    int? brandId,
    int? categoryId,
    String? productType,
    double? retailPrice,
    double? resellerPrice,
    int? productStock,
    bool? productStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<ProductVariant>? variants,
    List<ProductVariantOption>? variantOptions,
    List<ProductImage>? images,
  }) {
    return Product(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      productDesc: productDesc ?? this.productDesc,
      productThumb: productThumb ?? this.productThumb,
      brandId: brandId ?? this.brandId,
      categoryId: categoryId ?? this.categoryId,
      productType: productType ?? this.productType,
      retailPrice: retailPrice ?? this.retailPrice,
      resellerPrice: resellerPrice ?? this.resellerPrice,
      productStock: productStock ?? this.productStock,
      productStatus: productStatus ?? this.productStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      variants: variants ?? this.variants,
      variantOptions: variantOptions ?? this.variantOptions,
      images: images ?? this.images,
    );
  }
}

// product_variant.dart
class ProductVariant {
  final int? id;
  final int? productId;
  final String? productType;

  ProductVariant({
    this.id,
    this.productId,
    this.productType,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['id'],
      productId: json['product_id'],
      productType: json['product_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product_type': productType,
    };
  }
}

// product_variant_option.dart
class ProductVariantOption {
  final int? id;
  final int? productId;
  final String? variant1;
  final String? variant2;
  final double? retailPrice;
  final double? resellerPrice;
  final int? productStock;

  ProductVariantOption({
    this.id,
    this.productId,
    this.variant1,
    this.variant2,
    this.retailPrice,
    this.resellerPrice,
    this.productStock,
  });

  factory ProductVariantOption.fromJson(Map<String, dynamic> json) {
    return ProductVariantOption(
      id: json['id'],
      productId: json['product_id'],
      variant1: json['variant_1'],
      variant2: json['variant_2'],
      retailPrice: json['retail_price'] != null
          ? double.parse(json['retail_price'].toString())
          : null,
      resellerPrice: json['reseller_price'] != null
          ? double.parse(json['reseller_price'].toString())
          : null,
      productStock: json['product_stock'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'variant_1': variant1,
      'variant_2': variant2,
      'retail_price': retailPrice,
      'reseller_price': resellerPrice,
      'product_stock': productStock,
    };
  }
}

// product_image.dart
class ProductImage {
  final int? id;
  final int? productId;
  final String? imageUrl;

  ProductImage({
    this.id,
    this.productId,
    this.imageUrl,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      productId: json['product_id'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'image_url': imageUrl,
    };
  }
}
