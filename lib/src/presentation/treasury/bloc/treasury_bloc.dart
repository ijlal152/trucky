import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'treasury_event.dart';
part 'treasury_state.dart';

class TreasuryBloc extends Bloc<TreasuryEvent, TreasuryState> {
  TreasuryBloc() : super(const TreasuryState()) {
    on<LoadTreasuryData>(_onLoadTreasuryData);
  }

  Future<void> _onLoadTreasuryData(
    LoadTreasuryData event,
    Emitter<TreasuryState> emit,
  ) async {
    emit(state.copyWith(status: TreasuryStatus.loading));
    try {
      // TODO: Implement actual data loading logic
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: TreasuryStatus.loaded, message: null));
    } catch (e) {
      emit(state.copyWith(status: TreasuryStatus.error, message: e.toString()));
    }
  }
}
