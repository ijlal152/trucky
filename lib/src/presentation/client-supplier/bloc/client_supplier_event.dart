part of 'client_supplier_bloc.dart';

abstract class ClientSupplierEvent extends Equatable {
  const ClientSupplierEvent();

  @override
  List<Object?> get props => [];
}

class LoadClientsSuppliers extends ClientSupplierEvent {
  const LoadClientsSuppliers();
}
