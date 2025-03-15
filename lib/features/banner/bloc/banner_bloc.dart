import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_admin/features/banner/bloc/banner_event.dart';
import 'package:neo_admin/features/banner/bloc/banner_state.dart';
import 'package:neo_admin/features/banner/data/banner_service.dart';

// BLOC State Management
// untuk fitur Kelola Banner
class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final BannerService bannerService;

  BannerBloc(this.bannerService) : super(BannerInitial()) {
    // Memuat banner
    on<LoadBanners>((event, emit) async {
      try {
        final banners = await bannerService.fetchBanners();
        emit(BannerLoaded(banners));
      } catch (e) {
        emit(BannerError(e.toString()));
      }
    });

    // Menambah banner
    on<AddBanners>((event, emit) async {
      try {
        add(LoadBanners());
        final imageUrl = await bannerService.uploadImage(
          'banner',
          event.imageBytes,
        );
        await bannerService.addBanners(event.page, imageUrl, event.isActive);
        add(LoadBanners());
      } catch (e) {
        emit(BannerError(e.toString()));
      }
    });

    // Mengubah banner
    on<UpdateBanners>((event, emit) async {
      try {
        add(LoadBanners());
        await bannerService.updateBanner(
          event.id,
          event.page,
          event.isActive,
          event.imageBytes,
        );
        add(LoadBanners());
      } catch (e) {
        emit(BannerError(e.toString()));
      }
    });

    // Menghapus banner
    on<DeleteBanners>((event, emit) async {
      try {
        add(LoadBanners());
        await bannerService.deleteBanners(event.id);
        add(LoadBanners());
      } catch (e) {
        emit(BannerError(e.toString()));
      }
    });
  }
}
