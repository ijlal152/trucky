import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/auth_usecases/load_user_session_uc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final LoadUserSessionUseCase _loadUserSessionUseCase;

  SplashBloc(this._loadUserSessionUseCase) : super(const SplashState()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<SplashState> emit,
  ) async {
    emit(state.copyWith(status: SplashStatus.loading));
    // Brief delay so the splash screen is visible
    await Future.delayed(const Duration(seconds: 2));

    try {
      final user = await _loadUserSessionUseCase(null);
      if (user != null) {
        emit(state.copyWith(status: SplashStatus.authenticated));
      } else {
        emit(state.copyWith(status: SplashStatus.unauthenticated));
      }
    } catch (_) {
      emit(state.copyWith(status: SplashStatus.unauthenticated));
    }
  }
}
