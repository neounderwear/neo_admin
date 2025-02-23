import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_admin/features/brand/bloc/brand_event.dart';
import 'package:neo_admin/features/brand/bloc/brand_state.dart';
import 'package:neo_admin/features/brand/data/brand_service.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  final BrandService brandService;

  BrandBloc(this.brandService) : super(BrandInitial()) {
    // Memuat data merek
    on<LoadBrands>((event, emit) async {
      try {
        final brands = await brandService.fetchBrands();
        emit(BrandLoaded(brands));
      } catch (e) {
        emit(BrandError(e.toString()));
      }
    });

    // Menambah data merek
    on<AddBrands>((event, emit) async {
      try {
        add(LoadBrands());
        final imageUrl = await brandService.uploadImage(
          'brand',
          event.imageBytes,
        );
        await brandService.addBrands(event.name, imageUrl);
        add(LoadBrands());
      } catch (e) {
        emit(BrandError(e.toString()));
      }
    });

    // Mengubah data merek
    on<UpdateBrands>((event, emit) async {
      try {
        add(LoadBrands());
        await brandService.updateBrands(event.id, event.name, event.imageBytes);
        add(LoadBrands());
      } catch (e) {
        emit(BrandError(e.toString()));
      }
    });

    // Menghapus data merek
    on<DeleteBrands>((event, emit) async {
      try {
        add(LoadBrands());
        await brandService.deleteBrands(event.id);
        add(LoadBrands());
      } catch (e) {
        emit(BrandError(e.toString()));
      }
    });
  }
}
