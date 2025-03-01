// lib/services/supabase_service.dart

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:neo_admin/features/product/data/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path;

class SupabaseService {
  final SupabaseClient _supabaseClient;

  SupabaseService(this._supabaseClient);

  // Initialize Supabase
  static Future<SupabaseClient> initialize() async {
    await Supabase.initialize(
      url: 'YOUR_SUPABASE_URL',
      anonKey: 'YOUR_SUPABASE_ANON_KEY',
    );
    return Supabase.instance.client;
  }

  // Get current Supabase client
  static SupabaseClient get client => Supabase.instance.client;

  // BRANDS METHODS
  Future<List<Brand>> getBrands() async {
    try {
      final response = await _supabaseClient
          .from('brands')
          .select()
          .order('name', ascending: true);

      return response.map<Brand>((brand) => Brand.fromJson(brand)).toList();
    } catch (e) {
      print('Error getting brands: $e');
      rethrow;
    }
  }

  // CATEGORIES METHODS
  Future<List<Category>> getCategories() async {
    try {
      final response = await _supabaseClient
          .from('categories')
          .select()
          .order('name', ascending: true);

      return response
          .map<Category>((category) => Category.fromJson(category))
          .toList();
    } catch (e) {
      print('Error getting categories: $e');
      rethrow;
    }
  }

  // VARIANT TYPES METHODS
  Future<List<VariantType>> getVariantTypes() async {
    try {
      final response = await _supabaseClient
          .from('variant_types')
          .select()
          .order('name', ascending: true);

      return response
          .map<VariantType>((type) => VariantType.fromJson(type))
          .toList();
    } catch (e) {
      print('Error getting variant types: $e');
      rethrow;
    }
  }

  // PRODUCTS METHODS
  Future<List<Product>> getProducts() async {
    try {
      // First get all products with their brand and category names
      final response = await _supabaseClient.from('products').select('''
            *,
            brands(name),
            categories(name)
          ''').order('created_at', ascending: false);

      List<Product> products = [];

      for (var productData in response) {
        // Create basic product
        Product product = Product.fromJson({
          ...productData,
          'brand_name': productData['brands'] != null
              ? productData['brands']['name']
              : null,
          'category_name': productData['categories'] != null
              ? productData['categories']['name']
              : null,
        });

        // Get product details for non-variant products
        if (!product.hasVariants) {
          final detailsResponse = await _supabaseClient
              .from('product_details')
              .select()
              .eq('product_id', product.id!)
              .single();

          product = product.copyWith(
            productDetail: ProductDetail.fromJson(detailsResponse),
          );
        } else {
          // Get variants for products with variants
          final variantsResponse =
              await _supabaseClient.from('product_variants').select('''
                *,
                variant_types(name)
              ''').eq('product_id', product.id!);

          List<ProductVariant> variants = [];
          for (var variantData in variantsResponse) {
            variants.add(ProductVariant.fromJson({
              ...variantData,
              'variant_type_name': variantData['variant_types'] != null
                  ? variantData['variant_types']['name']
                  : null,
            }));
          }

          product = product.copyWith(variants: variants);
        }

        // Get product images
        final imagesResponse = await _supabaseClient
            .from('product_images')
            .select()
            .eq('product_id', product.id)
            .order('is_main', ascending: false);

        List<ProductImage> images = imagesResponse
            .map<ProductImage>((img) => ProductImage.fromJson(img))
            .toList();

        product = product.copyWith(images: images);
        products.add(product);
      }

      return products;
    } catch (e) {
      print('Error getting products: $e');
      rethrow;
    }
  }

  Future<Product> createProduct(
      Product product, List<dynamic> imageFiles) async {
    try {
      // Start a transaction
      final response = await _supabaseClient
          .from('products')
          .insert({
            'name': product.name,
            'description': product.description,
            'brand_id': product.brandId,
            'category_id': product.categoryId,
            'is_active': product.isActive,
            'has_variants': product.hasVariants,
          })
          .select()
          .single();

      final String productId = response['id'];

      // Handle product details for non-variant products
      if (!product.hasVariants && product.productDetail != null) {
        await _supabaseClient.from('product_details').insert({
          'product_id': productId,
          'price': product.productDetail!.price,
          'reseller_price': product.productDetail!.resellerPrice,
          'sku': product.productDetail!.sku,
          'stock': product.productDetail!.stock,
          'weight': product.productDetail!.weight,
        });
      }

      // Handle variants for products with variants
      if (product.hasVariants && product.variants.isNotEmpty) {
        for (var variant in product.variants) {
          await _supabaseClient.from('product_variants').insert({
            'product_id': productId,
            'variant_type_id': variant.variantTypeId,
            'variant_value': variant.variantValue,
            'price': variant.price,
            'reseller_price': variant.resellerPrice,
            'sku': variant.sku,
            'stock': variant.stock,
            'weight': variant.weight,
          });
        }
      }

      // Handle image uploads
      List<ProductImage> uploadedImages = [];
      if (imageFiles.isNotEmpty) {
        int index = 0;
        for (var imageFile in imageFiles) {
          final String imageUrl =
              await _uploadProductImage(productId, imageFile);

          final imageResponse = await _supabaseClient
              .from('product_images')
              .insert({
                'product_id': productId,
                'image_url': imageUrl,
                'is_main': index == 0, // First image is the main image
              })
              .select()
              .single();

          uploadedImages.add(ProductImage.fromJson(imageResponse));
          index++;
        }
      }

      // Return the complete product
      return product.copyWith(
        id: productId,
        images: uploadedImages,
      );
    } catch (e) {
      print('Error creating product: $e');
      rethrow;
    }
  }

  Future<String> _uploadProductImage(
      String productId, dynamic imageFile) async {
    try {
      String fileName;
      List<int> bytes;
      String fileExt;

      if (kIsWeb) {
        // Web platform handling
        html.File file = imageFile as html.File;
        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);
        await reader.onLoadEnd.first;
        bytes = reader.result as List<int>;
        fileName = file.name;
        fileExt = path.extension(fileName);
      } else {
        // Mobile/Desktop platform handling
        File file = imageFile as File;
        bytes = await file.readAsBytes();
        fileName = path.basename(file.path);
        fileExt = path.extension(fileName);
      }

      final String filePath =
          '$productId/${DateTime.now().millisecondsSinceEpoch}$fileExt';

      // Upload to Supabase Storage
      await _supabaseClient.storage
          .from('product_images')
          .uploadBinary(filePath, bytes);

      // Get public URL
      final imageUrl =
          _supabaseClient.storage.from('product_images').getPublicUrl(filePath);

      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      rethrow;
    }
  }

  Future<void> updateProduct(
      Product product, List<dynamic> newImageFiles) async {
    try {
      // Update basic product info
      await _supabaseClient.from('products').update({
        'name': product.name,
        'description': product.description,
        'brand_id': product.brandId,
        'category_id': product.categoryId,
        'is_active': product.isActive,
        'has_variants': product.hasVariants,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', product.id);

      // Handle non-variant products
      if (!product.hasVariants && product.productDetail != null) {
        // Check if product detail exists
        final existing = await _supabaseClient
            .from('product_details')
            .select()
            .eq('product_id', product.id);

        if (existing.isEmpty) {
          // Create if doesn't exist
          await _supabaseClient.from('product_details').insert({
            'product_id': product.id,
            'price': product.productDetail!.price,
            'reseller_price': product.productDetail!.resellerPrice,
            'sku': product.productDetail!.sku,
            'stock': product.productDetail!.stock,
            'weight': product.productDetail!.weight,
          });
        } else {
          // Update existing
          await _supabaseClient.from('product_details').update({
            'price': product.productDetail!.price,
            'reseller_price': product.productDetail!.resellerPrice,
            'sku': product.productDetail!.sku,
            'stock': product.productDetail!.stock,
            'weight': product.productDetail!.weight,
            'updated_at': DateTime.now().toIso8601String(),
          }).eq('product_id', product.id);
        }

        // Delete any variants if product now has no variants
        await _supabaseClient
            .from('product_variants')
            .delete()
            .eq('product_id', product.id);
      } else if (product.hasVariants) {
        // Delete product detail if product now has variants
        await _supabaseClient
            .from('product_details')
            .delete()
            .eq('product_id', product.id);

        // Handle variants - first delete existing ones
        await _supabaseClient
            .from('product_variants')
            .delete()
            .eq('product_id', product.id);

        // Then add all current variants
        for (var variant in product.variants) {
          await _supabaseClient.from('product_variants').insert({
            'product_id': product.id,
            'variant_type_id': variant.variantTypeId,
            'variant_value': variant.variantValue,
            'price': variant.price,
            'reseller_price': variant.resellerPrice,
            'sku': variant.sku,
            'stock': variant.stock,
            'weight': variant.weight,
          });
        }
      }

      // Handle new image uploads
      if (newImageFiles.isNotEmpty) {
        for (var imageFile in newImageFiles) {
          final String imageUrl =
              await _uploadProductImage(product.id!, imageFile);

          await _supabaseClient.from('product_images').insert({
            'product_id': product.id,
            'image_url': imageUrl,
            'is_main': false, // New uploads are not main by default
          });
        }
      }
    } catch (e) {
      print('Error updating product: $e');
      rethrow;
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      // Delete product (cascade will delete details, variants, and images)
      await _supabaseClient.from('products').delete().eq('id', productId);

      // Delete images from storage
      try {
        await _supabaseClient.storage
            .from('product_images')
            .remove([productId]);
      } catch (e) {
        // Storage folder might not exist if no images were uploaded
        print('Warning when deleting storage: $e');
      }
    } catch (e) {
      print('Error deleting product: $e');
      rethrow;
    }
  }

  Future<void> setMainProductImage(String productId, String imageId) async {
    try {
      // First, reset all images to non-main
      await _supabaseClient
          .from('product_images')
          .update({'is_main': false}).eq('product_id', productId);

      // Then set the selected image as main
      await _supabaseClient
          .from('product_images')
          .update({'is_main': true}).eq('id', imageId);
    } catch (e) {
      print('Error setting main image: $e');
      rethrow;
    }
  }

  Future<void> deleteProductImage(String imageId, String imageUrl) async {
    try {
      // Delete from database
      await _supabaseClient.from('product_images').delete().eq('id', imageId);

      // Extract storage path from URL
      final Uri uri = Uri.parse(imageUrl);
      final String storagePath = uri.pathSegments.last;

      // Delete from storage
      try {
        await _supabaseClient.storage
            .from('product_images')
            .remove([storagePath]);
      } catch (e) {
        print('Warning when deleting image file: $e');
      }
    } catch (e) {
      print('Error deleting image: $e');
      rethrow;
    }
  }
}
