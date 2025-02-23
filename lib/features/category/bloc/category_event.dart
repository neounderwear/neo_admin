import 'dart:typed_data';

abstract class CategoryEvent {}

class LoadCategories extends CategoryEvent {}

class AddCategories extends CategoryEvent {
  final String name;
  final Uint8List imageBytes;

  AddCategories(this.name, this.imageBytes);
}

class UpdateCategories extends CategoryEvent {
  final String id, name;
  final Uint8List? imageBytes;

  UpdateCategories(this.id, this.name, this.imageBytes);
}

class DeleteCategories extends CategoryEvent {
  final String id;

  DeleteCategories(this.id);
}
