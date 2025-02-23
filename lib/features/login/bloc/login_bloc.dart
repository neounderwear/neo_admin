import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_admin/features/login/bloc/login_event.dart';
import 'package:neo_admin/features/login/bloc/login_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SupabaseClient supabase = Supabase.instance.client;

  LoginBloc() : super(LoginInitial()) {
    // Login Bloc
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        final response = await supabase.auth.signInWithPassword(
          email: event.email,
          password: event.password,
        );

        if (response.user != null) {
          emit(LoginSuccess());
        } else {
          emit(LoginFailure(message: 'Email dan Password tidak sesuai'));
        }
      } catch (e) {
        emit(LoginFailure(message: 'Terjadi kesalahan, silakan coba lagi'));
      }
    });

    // Logout Bloc
    on<LogoutRequested>((event, emit) async {
      try {
        await supabase.auth.signOut();
        emit(LogoutSuccess());
      } catch (e) {
        emit(LogoutFailure('Gagal keluar'));
      }
    });
  }
}
