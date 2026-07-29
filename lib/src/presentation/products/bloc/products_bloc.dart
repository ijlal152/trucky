import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trucky/main.dart' as app;
import 'package:trucky/src/data/models/product_model.dart';
import 'package:trucky/src/domain/repositories/product_repo.dart';
import 'package:uuid/uuid.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  late final ProductRepository _productRepository;

  ProductsBloc() : super(const ProductsState()) {
    _productRepository = app.productRepository;

    on<LoadProducts>(_onLoadProducts);
    on<ToggleBalanceVisibility>(_onToggleBalanceVisibility);
    on<CalculateTotalStockValue>(_onCalculateTotalStockValue);
    on<AddProductEvent>(_onAddProduct);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductsState> emit,
  ) async {
    emit(state.copyWith(status: ProductsStatus.loading));
    try {
      final products = await _productRepository.getAllProducts();
      final total = await _productRepository.getTotalStockValue();
      emit(state.copyWith(
        status: ProductsStatus.loaded,
        products: products,
        totalStockValue: total,
        message: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductsStatus.error,
        message: e.toString(),
      ));
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
      final total = await _productRepository.getTotalStockValue();
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
      final product = ProductModel(
        id: const Uuid().v4(),
        productName: event.productName,
        productSKU: event.productSKU,
        purchasePrice: event.purchasePrice,
        sellingPrice: event.sellingPrice,
        initialQuantity: event.initialQuantity,
        quantityPerPackage: event.quantityPerPackage,
        productImage: event.productImage,
      );

      await _productRepository.addProduct(product);

      // Reload products after adding
      final products = await _productRepository.getAllProducts();
      final total = await _productRepository.getTotalStockValue();

      emit(state.copyWith(
        status: ProductsStatus.loaded,
        products: products,
        totalStockValue: total,
        message: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductsStatus.error,
        message: e.toString(),
      ));
    }
  }
}
