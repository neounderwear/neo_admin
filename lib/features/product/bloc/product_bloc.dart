import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_admin/features/product/bloc/product_event.dart';
import 'package:neo_admin/features/product/bloc/product_state.dart';
import 'package:neo_admin/features/product/data/product_service.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService productService;

  ProductBloc(this.productService) : super(ProductInitial()) {
    // Menampilkan produk
    on<LoadProducts>((event, emit) async {
      try {
        emit(ProductLoading());
        final product = await productService.getProducts();
        emit(ProductLoaded(product));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    // Menampilkan produk berdasarkan ID
    on<LoadProductById>((event, emit) async {
      try {
        emit(ProductLoading());
        final product = await productService.getProductById(event.id);
        emit(SingleProductLoaded(product));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    // Menambah produk baru
    on<AddProducts>((event, emit) async {
      try {
        emit(ProductLoading());
        await productService.createProduct(event.product);
        final product = await productService.getProducts();
        emit(ProductLoaded(product));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    // Mengupdate data produk
    on<UpdateProducts>((event, emit) async {
      try {
        emit(ProductLoading());
        await productService.updateProduct(event.product);
        final product = await productService.getProducts();
        emit(ProductLoaded(product));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    // Menghapus produk
    on<DeleteProducts>((event, emit) async {
      try {
        emit(ProductLoading());
        await productService.deleteProduct(event.id);
        final product = await productService.getProducts();
        emit(ProductLoaded(product));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}
