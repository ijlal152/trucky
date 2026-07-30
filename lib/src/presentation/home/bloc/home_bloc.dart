import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trucky/core/di/service_locator.dart';
import 'package:trucky/src/domain/repositories/product_repo.dart';
import 'package:trucky/src/domain/repositories/product_transaction_repo.dart';

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
      final productRepo = sl<ProductRepository>();
      final transactionRepo = sl<ProductTransactionRepository>();

      // Load product count and stock value
      final products = await productRepo.getAllProducts();
      final productCount = products.length;
      final totalStockValue = await productRepo.getTotalStockValue();

      // Aggregate sale & purchase counts across all products
      int saleCount = 0;
      int purchaseCount = 0;
      for (final product in products) {
        saleCount += await transactionRepo.getTotalSoldForProduct(product.id);
        purchaseCount += await transactionRepo.getTotalPurchasedForProduct(
          product.id,
        );
      }

      // Client & supplier counts – repos not fully implemented yet, default 0
      emit(
        state.copyWith(
          status: HomeStatus.loaded,
          productCount: productCount,
          totalStockValue: totalStockValue,
          saleCount: saleCount,
          purchaseCount: purchaseCount,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error, message: e.toString()));
    }
  }

  Future<void> _onRefreshHomeData(
    RefreshHomeData event,
    Emitter<HomeState> emit,
  ) async {
    try {
      add(const LoadHomeData());
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error, message: e.toString()));
    }
  }
}
