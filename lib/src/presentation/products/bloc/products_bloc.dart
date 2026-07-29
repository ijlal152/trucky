import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(const ProductsState()) {
    on<LoadProducts>(_onLoadProducts);
    on<ToggleBalanceVisibility>(_onToggleBalanceVisibility);
    on<CalculateTotalStockValue>(_onCalculateTotalStockValue);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductsState> emit,
  ) async {
    emit(state.copyWith(status: ProductsStatus.loading));
    try {
      // TODO: Implement actual data loading logic
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: ProductsStatus.loaded, message: null));
    } catch (e) {
      emit(state.copyWith(status: ProductsStatus.error, message: e.toString()));
    }
  }

  void _onToggleBalanceVisibility(
    ToggleBalanceVisibility event,
    Emitter<ProductsState> emit,
  ) {
    emit(state.copyWith(hideBalance: !state.hideBalance));
  }

  Future<void> _onCalculateTotalStockValue(
    CalculateTotalStockValue event,
    Emitter<ProductsState> emit,
  ) async {
    // TODO: Calculate total stock value from actual products
    emit(state.copyWith(totalStockValue: 0.0));
  }
}
