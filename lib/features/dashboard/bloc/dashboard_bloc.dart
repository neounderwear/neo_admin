import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_admin/features/dashboard/bloc/dashboard_event.dart';
import 'package:neo_admin/features/dashboard/bloc/dashboard_state.dart';
import 'package:neo_admin/features/dashboard/data/dashboard_service.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardService service;

  DashboardBloc(this.service) : super(DashboardInitial()) {
    on<FetchDashboardData>((event, emit) async {
      emit(DashboardLoading());
      try {
        final data = await service.fetchDashboardData();
        emit(DashboardLoaded(data));
      } catch (e) {
        emit(DashboardError('Error: $e'));
      }
    });
  }
}
