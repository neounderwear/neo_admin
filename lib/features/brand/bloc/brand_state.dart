abstract class BrandState {}

class BrandInitial extends BrandState {}

class BrandLoading extends BrandState {}

class BrandLoaded extends BrandState {
  final List<Map<String, dynamic>> brands;

  BrandLoaded(this.brands);
}

class BrandError extends BrandState {
  final String message;

  BrandError(this.message);
}
