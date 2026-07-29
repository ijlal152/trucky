part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductsEvent {
  const LoadProducts();
}

class ToggleBalanceVisibility extends ProductsEvent {
  const ToggleBalanceVisibility();
}

class CalculateTotalStockValue extends ProductsEvent {
  const CalculateTotalStockValue();
}
