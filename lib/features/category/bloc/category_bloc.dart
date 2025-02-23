import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_admin/features/category/bloc/category_event.dart';
import 'package:neo_admin/features/category/bloc/category_state.dart';
import 'package:neo_admin/features/category/data/category_service.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryService categoryService;

  CategoryBloc(this.categoryService) : super(CategoryInitial()) {
    // Memuat data kategori
    on<LoadCategories>((event, emit) async {
      try {
        final categories = await categoryService.fetchCategories();
        emit(CategoryLoaded(categories));
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });

    // Menambah data kategori
    on<AddCategories>((event, emit) async {
      try {
        add(LoadCategories());
        final imageUrl = await categoryService.uploadImage(
          'categories',
          event.imageBytes,
        );
        await categoryService.addCategories(event.name, imageUrl);
        add(LoadCategories());
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });

    // Mengubah data kategori
    on<UpdateCategories>((event, emit) async {
      try {
        add(LoadCategories());
        await categoryService.updateCategories(
          event.id,
          event.name,
          event.imageBytes,
        );
        add(LoadCategories());
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });

    // Menghapus data kategori
    on<DeleteCategories>((event, emit) async {
      try {
        add(LoadCategories());
        await categoryService.deleteCategories(event.id);
        add(LoadCategories());
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });
  }
}
