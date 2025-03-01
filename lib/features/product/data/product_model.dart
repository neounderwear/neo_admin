class Product {
  final String? id;
  final String name;
  final String description;
  final String? brandId;
  final String? categoryId;
  final bool isActive;
  final bool hasVariants;
  final ProductDetail? productDetail;
  final List<ProductVariant> variants;
  final List<ProductImage> images;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? brandName;
  final String? categoryName;

  Product({
    this.id,
    required this.name,
    required this.description,
    this.brandId,
    this.categoryId,
    this.isActive = true,
    this.hasVariants = false,
    this.productDetail,
    this.variants = const [],
    this.images = const [],
    this.createdAt,
    this.updatedAt,
    this.brandName,
    this.categoryName,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'brand_id': brandId,
      'category_id': categoryId,
      'is_active': isActive,
      'has_variants': hasVariants,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      brandId: json['brand_id'],
      categoryId: json['category_id'],
      isActive: json['is_active'] ?? true,
      hasVariants: json['has_variants'] ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      brandName: json['brand_name'],
      categoryName: json['category_name'],
    );
  }

  Product copyWith({
    String? id,
    String? name,
    String? description,
    String? brandId,
    String? categoryId,
    bool? isActive,
    bool? hasVariants,
    ProductDetail? productDetail,
    List<ProductVariant>? variants,
    List<ProductImage>? images,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? brandName,
    String? categoryName,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      brandId: brandId ?? this.brandId,
      categoryId: categoryId ?? this.categoryId,
      isActive: isActive ?? this.isActive,
      hasVariants: hasVariants ?? this.hasVariants,
      productDetail: productDetail ?? this.productDetail,
      variants: variants ?? this.variants,
      images: images ?? this.images,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      brandName: brandName ?? this.brandName,
      categoryName: categoryName ?? this.categoryName,
    );
  }
}

class ProductDetail {
  final String? id;
  final String? productId;
  final double price;
  final double? resellerPrice;
  final String? sku;
  final int stock;
  final double? weight;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductDetail({
    this.id,
    this.productId,
    required this.price,
    this.resellerPrice,
    this.sku,
    this.stock = 0,
    this.weight,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'price': price,
      'reseller_price': resellerPrice,
      'sku': sku,
      'stock': stock,
      'weight': weight,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      id: json['id'],
      productId: json['product_id'],
      price: (json['price'] is String)
          ? double.parse(json['price'])
          : json['price'].toDouble(),
      resellerPrice: json['reseller_price'] != null
          ? (json['reseller_price'] is String)
              ? double.parse(json['reseller_price'])
              : json['reseller_price'].toDouble()
          : null,
      sku: json['sku'],
      stock: json['stock'] ?? 0,
      weight: json['weight'] != null
          ? (json['weight'] is String)
              ? double.parse(json['weight'])
              : json['weight'].toDouble()
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}

class VariantType {
  final String? id;
  final String name;
  final DateTime? createdAt;

  VariantType({
    this.id,
    required this.name,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  factory VariantType.fromJson(Map<String, dynamic> json) {
    return VariantType(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
}

class ProductVariant {
  final String? id;
  final String? productId;
  final String? variantTypeId;
  final String variantValue;
  final double price;
  final double? resellerPrice;
  final String? sku;
  final int stock;
  final double? weight;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? variantTypeName;

  ProductVariant({
    this.id,
    this.productId,
    this.variantTypeId,
    required this.variantValue,
    required this.price,
    this.resellerPrice,
    this.sku,
    this.stock = 0,
    this.weight,
    this.createdAt,
    this.updatedAt,
    this.variantTypeName,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'variant_type_id': variantTypeId,
      'variant_value': variantValue,
      'price': price,
      'reseller_price': resellerPrice,
      'sku': sku,
      'stock': stock,
      'weight': weight,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['id'],
      productId: json['product_id'],
      variantTypeId: json['variant_type_id'],
      variantValue: json['variant_value'],
      price: (json['price'] is String)
          ? double.parse(json['price'])
          : json['price'].toDouble(),
      resellerPrice: json['reseller_price'] != null
          ? (json['reseller_price'] is String)
              ? double.parse(json['reseller_price'])
              : json['reseller_price'].toDouble()
          : null,
      sku: json['sku'],
      stock: json['stock'] ?? 0,
      weight: json['weight'] != null
          ? (json['weight'] is String)
              ? double.parse(json['weight'])
              : json['weight'].toDouble()
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      variantTypeName: json['variant_type_name'],
    );
  }

  String getDisplayName() {
    return '$variantTypeName: $variantValue';
  }
}

class ProductImage {
  final String? id;
  final String? productId;
  final String imageUrl;
  final bool isMain;
  final DateTime? createdAt;
  final dynamic imageFile;

  ProductImage({
    this.id,
    this.productId,
    required this.imageUrl,
    this.isMain = false,
    this.createdAt,
    this.imageFile,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'image_url': imageUrl,
      'is_main': isMain,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      productId: json['product_id'],
      imageUrl: json['image_url'],
      isMain: json['is_main'] ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
}

class Brand {
  final String id;
  final String name;

  Brand({
    required this.id,
    required this.name,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Category {
  final String id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}
