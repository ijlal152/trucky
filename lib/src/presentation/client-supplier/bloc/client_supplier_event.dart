part of 'client_supplier_bloc.dart';

abstract class ClientSupplierEvent extends Equatable {
  const ClientSupplierEvent();

  @override
  List<Object?> get props => [];
}

/// Load all clients/suppliers
class LoadClientsSuppliers extends ClientSupplierEvent {
  final EntityType entityType;
  const LoadClientsSuppliers({this.entityType = EntityType.client});

  @override
  List<Object?> get props => [entityType];
}

/// Add a new client or supplier
class AddClientSupplier extends ClientSupplierEvent {
  final ClientSuppEntity contact;

  const AddClientSupplier({required this.contact});

  @override
  List<Object?> get props => [contact];
}

/// Delete a client or supplier
class DeleteClientSupplier extends ClientSupplierEvent {
  final String id;
  const DeleteClientSupplier({required this.id});

  @override
  List<Object?> get props => [id];
}

/// Select a contact by ID to view its dashboard.
class SelectClientSupplier extends ClientSupplierEvent {
  final String id;
  const SelectClientSupplier({required this.id});

  @override
  List<Object?> get props => [id];
}

/// Toggle search field visibility
class ToggleSearchField extends ClientSupplierEvent {
  final bool isVisible;
  const ToggleSearchField({required this.isVisible});

  @override
  List<Object?> get props => [isVisible];
}

/// Search clients/suppliers
class SearchClientSupplier extends ClientSupplierEvent {
  final String query;
  const SearchClientSupplier({required this.query});

  @override
  List<Object?> get props => [query];
}

/// Sort the list
class SortClientSupplierList extends ClientSupplierEvent {
  final int sortIndex;
  const SortClientSupplierList({required this.sortIndex});

  @override
  List<Object?> get props => [sortIndex];
}
