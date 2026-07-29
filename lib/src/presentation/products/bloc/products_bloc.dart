import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trucky/core/usecase/usecase.dart';
import 'package:trucky/src/data/models/product_model.dart';
import 'package:trucky/src/data/models/product_transaction_model.dart';
import 'package:trucky/src/domain/usecases/product_usecases/add_product_uc.dart';
import 'package:trucky/src/domain/usecases/product_usecases/get_all_products_uc.dart';
import 'package:trucky/src/domain/usecases/product_usecases/get_product_transactions_uc.dart';
import 'package:trucky/src/domain/usecases/product_usecases/get_total_stock_value_uc.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  late final GetAllProductsUseCase _getAllProductsUseCase;
  late final GetTotalStockValueUseCase _getTotalStockValueUseCase;
  late final AddProductUseCase _addProductUseCase;
  late final GetProductTransactionsUseCase _getTransactionsUseCase;

  ProductsBloc() : super(const ProductsState()) {
    _getAllProductsUseCase = GetIt.instance<GetAllProductsUseCase>();
    _getTotalStockValueUseCase = GetIt.instance<GetTotalStockValueUseCase>();
    _addProductUseCase = GetIt.instance<AddProductUseCase>();
    _getTransactionsUseCase = GetIt.instance<GetProductTransactionsUseCase>();

    on<LoadProducts>(_onLoadProducts);
    on<ToggleBalanceVisibility>(_onToggleBalanceVisibility);
    on<CalculateTotalStockValue>(_onCalculateTotalStockValue);
    on<AddProductEvent>(_onAddProduct);
    on<LoadProductTransactions>(_onLoadProductTransactions);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductsState> emit,
  ) async {
    emit(state.copyWith(status: ProductsStatus.loading));
    try {
      final products = await _getAllProductsUseCase(NoParams());
      final total = await _getTotalStockValueUseCase(NoParams());
      emit(
        state.copyWith(
          status: ProductsStatus.loaded,
          products: products,
          totalStockValue: total,
          message: null,
        ),
      );
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
    try {
      final total = await _getTotalStockValueUseCase(NoParams());
      emit(state.copyWith(totalStockValue: total));
    } catch (e) {
      emit(state.copyWith(totalStockValue: 0.0));
    }
  }

  Future<void> _onAddProduct(
    AddProductEvent event,
    Emitter<ProductsState> emit,
  ) async {
    try {
      await _addProductUseCase(
        AddProductParams(
          productName: event.productName,
          productSKU: event.productSKU,
          purchasePrice: event.purchasePrice,
          sellingPrice: event.sellingPrice,
          initialQuantity: event.initialQuantity,
          quantityPerPackage: event.quantityPerPackage,
          productImage: event.productImage,
        ),
      );

      // Reload products after adding
      final products = await _getAllProductsUseCase(NoParams());
      final total = await _getTotalStockValueUseCase(NoParams());

      emit(
        state.copyWith(
          status: ProductsStatus.loaded,
          products: products,
          totalStockValue: total,
          message: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: ProductsStatus.error, message: e.toString()));
    }
  }

  Future<void> _onLoadProductTransactions(
    LoadProductTransactions event,
    Emitter<ProductsState> emit,
  ) async {
    try {
      final transactions = await _getTransactionsUseCase(
        GetProductTransactionsParams(productId: event.productId),
      );

      // Compute stats from transactions
      int sold = 0, purchased = 0, available = 0;
      for (final t in transactions) {
        available += t.quantity;
        if (t.type == 'sale') sold += t.quantity.abs();
        if (t.type == 'purchase') purchased += t.quantity;
      }

      emit(
        state.copyWith(
          transactions: transactions,
          totalSold: sold,
          totalPurchased: purchased,
          availableStock: available,
        ),
      );
    } catch (e) {
      emit(state.copyWith(message: e.toString()));
    }
  }
}
