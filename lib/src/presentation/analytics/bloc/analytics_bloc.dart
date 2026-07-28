import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  AnalyticsBloc() : super(const AnalyticsState()) {
    on<LoadAnalyticsData>(_onLoadAnalyticsData);
  }

  Future<void> _onLoadAnalyticsData(
    LoadAnalyticsData event,
    Emitter<AnalyticsState> emit,
  ) async {
    emit(state.copyWith(status: AnalyticsStatus.loading));
    try {
      // TODO: Implement actual data loading logic
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: AnalyticsStatus.loaded, message: null));
    } catch (e) {
      emit(
        state.copyWith(status: AnalyticsStatus.error, message: e.toString()),
      );
    }
  }
}
