import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_admin/features/brand/bloc/brand_event.dart';
import 'package:neo_admin/features/brand/bloc/brand_state.dart';
import 'package:neo_admin/features/brand/data/brand_service.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  final BrandService brandService;

  BrandBloc(this.brandService) : super(BrandState([])) {
    // Memuat data merek
    on<LoadBrands>((event, emit) async {
      final brands = await brandService.fetchBrands();
      emit(BrandState(brands));
    });

    // Menambah data merek
    on<AddBrands>((event, emit) async {
      add(LoadBrands());
      final imageUrl =
          await brandService.uploadImage('brand', event.imageBytes);
      await brandService.addBrands(event.name, imageUrl);
      add(LoadBrands());
    });

    // Mengubah data merek
    on<UpdateBrands>((event, emit) async {
      add(LoadBrands());

      await brandService.updateBrands(event.id, event.name, event.imageBytes);
      add(LoadBrands());
    });

    // Menghapus data merek
    on<DeleteBrands>((event, emit) async {
      add(LoadBrands());
      await brandService.deleteBrands(event.id);
      add(LoadBrands());
    });
  }
}
