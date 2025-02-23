import 'dart:typed_data';

abstract class BannerEvent {}

class LoadBanners extends BannerEvent {}

class AddBanners extends BannerEvent {
  final String page;
  final bool isActive;
  final Uint8List imageBytes;

  AddBanners(this.page, this.isActive, this.imageBytes);
}

class UpdateBanners extends BannerEvent {
  final String id, page;
  final bool isActive;
  final Uint8List? imageBytes;

  UpdateBanners(this.id, this.page, this.isActive, this.imageBytes);
}

class DeleteBanners extends BannerEvent {
  final String id;

  DeleteBanners(this.id);
}
