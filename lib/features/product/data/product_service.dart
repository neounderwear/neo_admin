import 'package:neo_admin/features/product/data/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  final SupabaseClient _supabaseClient;

  ProductService(this._supabaseClient);

  Future<List<Product>> getProducts() async {
    try {
      final response = await _supabaseClient.from('products').select('''
            *,
            product_variants(*),
            product_variant_options(*),
            product_images(*)
          ''');

      final List<dynamic> data = response as List<dynamic>;
      return data.map((json) {
        final product = Product.fromJson(json);

        if (json['product_variants'] != null) {
          product.variants?.addAll(
            (json['product_variants'] as List)
                .map((v) => ProductVariant.fromJson(v))
                .toList(),
          );
        }

        if (json['product_variant_options'] != null) {
          product.variantOptions?.addAll(
            (json['product_variant_options'] as List)
                .map((v) => ProductVariantOption.fromJson(v))
                .toList(),
          );
        }

        if (json['product_images'] != null) {
          product.images?.addAll(
            (json['product_images'] as List)
                .map((v) => ProductImage.fromJson(v))
                .toList(),
          );
        }

        return product;
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  Future<Product> getProductById(int id) async {
    try {
      final response = await _supabaseClient.from('products').select('''
            *,
            product_variants(*),
            product_variant_options(*),
            product_images(*)
          ''').eq('id', id).single();

      return Product.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch product: $e');
    }
  }

  Future<void> createProduct(Product product) async {
    try {
      await _supabaseClient.from('products').insert(product.toJson());
    } catch (e) {
      throw Exception('Failed to create product: $e');
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await _supabaseClient
          .from('products')
          .update(product.toJson())
          .eq('id', product.id);
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      await _supabaseClient.from('products').delete().eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }
}
