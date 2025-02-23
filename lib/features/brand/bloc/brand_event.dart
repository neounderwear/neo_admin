import 'dart:typed_data';

abstract class BrandEvent {}

class LoadBrands extends BrandEvent {}

class AddBrands extends BrandEvent {
  final String name;
  final Uint8List imageBytes;

  AddBrands(this.name, this.imageBytes);
}

class UpdateBrands extends BrandEvent {
  final String id, name;
  final Uint8List? imageBytes;

  UpdateBrands(this.id, this.name, this.imageBytes);
}

class DeleteBrands extends BrandEvent {
  final String id;

  DeleteBrands(this.id);
}
