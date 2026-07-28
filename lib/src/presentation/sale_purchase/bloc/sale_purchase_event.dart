part of 'sale_purchase_bloc.dart';

abstract class SalePurchaseEvent extends Equatable {
  const SalePurchaseEvent();

  @override
  List<Object?> get props => [];
}

class LoadSalePurchaseData extends SalePurchaseEvent {
  const LoadSalePurchaseData();
}
