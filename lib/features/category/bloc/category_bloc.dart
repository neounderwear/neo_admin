import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_admin/features/category/bloc/category_event.dart';
import 'package:neo_admin/features/category/bloc/category_state.dart';
import 'package:neo_admin/features/category/data/category_service.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryService categoryService;

  CategoryBloc(this.categoryService) : super(CategoryState([])) {
    // Memuat data kategori
    on<LoadCategories>((event, emit) async {
      final categories = await categoryService.fetchCategories();
      emit(CategoryState(categories));
    });

    // Menambah data kategori
    on<AddCategories>((event, emit) async {
      add(LoadCategories());
      final imageUrl =
          await categoryService.uploadImage('categories', event.imageBytes);
      await categoryService.addCategories(event.name, imageUrl);
    });

    // Mengubah data kategori
    on<UpdateCategories>((event, emit) async {
      add(LoadCategories());
      await categoryService.updateCategories(
          event.id, event.name, event.imageBytes);
      add(LoadCategories());
    });

    // Menghapus data kategori
    on<DeleteCategories>((event, emit) async {
      add(LoadCategories());
      await categoryService.deleteCategories(event.id);
      add(LoadCategories());
    });
  }
}
