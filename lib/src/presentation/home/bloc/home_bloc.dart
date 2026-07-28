import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<RefreshHomeData>(_onRefreshHomeData);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      // TODO: Implement actual data loading logic
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: HomeStatus.loaded, message: null));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error, message: e.toString()));
    }
  }

  Future<void> _onRefreshHomeData(
    RefreshHomeData event,
    Emitter<HomeState> emit,
  ) async {
    try {
      // TODO: Implement actual data refresh logic
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: HomeStatus.loaded, message: null));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error, message: e.toString()));
    }
  }
}
