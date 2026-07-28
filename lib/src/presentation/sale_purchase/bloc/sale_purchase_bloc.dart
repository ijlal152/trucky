import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sale_purchase_event.dart';
part 'sale_purchase_state.dart';

class SalePurchaseBloc extends Bloc<SalePurchaseEvent, SalePurchaseState> {
  SalePurchaseBloc() : super(const SalePurchaseState()) {
    on<LoadSalePurchaseData>(_onLoadSalePurchaseData);
  }

  Future<void> _onLoadSalePurchaseData(
    LoadSalePurchaseData event,
    Emitter<SalePurchaseState> emit,
  ) async {
    emit(state.copyWith(status: SalePurchaseStatus.loading));
    try {
      // TODO: Implement actual data loading logic
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: SalePurchaseStatus.loaded, message: null));
    } catch (e) {
      emit(
        state.copyWith(status: SalePurchaseStatus.error, message: e.toString()),
      );
    }
  }
}
