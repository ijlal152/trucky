import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<SplashState> emit,
  ) async {
    emit(state.copyWith(status: SplashStatus.loading));
    // Simulate splash delay and check authentication status
    await Future.delayed(const Duration(seconds: 2));

    // TODO: Replace with actual auth check logic (e.g., check stored token)
    final isLoggedIn = await _checkAuthentication();

    if (isLoggedIn) {
      emit(state.copyWith(status: SplashStatus.authenticated));
    } else {
      emit(state.copyWith(status: SplashStatus.unauthenticated));
    }
  }

  Future<bool> _checkAuthentication() async {
    // TODO: Implement actual authentication check
    // e.g., check if user token exists in secure storage
    return false;
  }
}
