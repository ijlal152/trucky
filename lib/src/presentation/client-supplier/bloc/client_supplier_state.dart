part of 'client_supplier_bloc.dart';

enum ClientSupplierStatus { initial, loading, loaded, added, deleted, error }

class ClientSupplierState extends Equatable {
  final ClientSupplierStatus status;
  final String? message;
  final EntityType entityType;
  final List<ClientSuppEntity> entities;
  final List<ClientSuppEntity> filteredEntities;
  final bool showSearchField;
  final String searchQuery;
  final String? selectedEntityId;
  final int sortIndex;

  const ClientSupplierState({
    this.status = ClientSupplierStatus.initial,
    this.message,
    this.entityType = EntityType.client,
    this.entities = const [],
    this.filteredEntities = const [],
    this.showSearchField = false,
    this.searchQuery = '',
    this.selectedEntityId,
    this.sortIndex = 0,
  });

  ClientSupplierState copyWith({
    ClientSupplierStatus? status,
    String? message,
    EntityType? entityType,
    List<ClientSuppEntity>? entities,
    List<ClientSuppEntity>? filteredEntities,
    bool? showSearchField,
    String? searchQuery,
    String? selectedEntityId,
    int? sortIndex,
    bool clearSelected = false,
  }) {
    return ClientSupplierState(
      status: status ?? this.status,
      message: message,
      entityType: entityType ?? this.entityType,
      entities: entities ?? this.entities,
      filteredEntities: filteredEntities ?? this.filteredEntities,
      showSearchField: showSearchField ?? this.showSearchField,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedEntityId: clearSelected
          ? null
          : (selectedEntityId ?? this.selectedEntityId),
      sortIndex: sortIndex ?? this.sortIndex,
    );
  }

  /// The selected entity, if any.
  ClientSuppEntity? get selectedEntity {
    if (selectedEntityId == null) return null;
    try {
      return entities.firstWhere((e) => e.id == selectedEntityId);
    } catch (_) {
      return null;
    }
  }

  /// Returns filtered list when searching, full list otherwise.
  List<ClientSuppEntity> get displayList =>
      showSearchField && searchQuery.isNotEmpty ? filteredEntities : entities;

  @override
  List<Object?> get props => [
    status,
    message,
    entityType,
    entities,
    filteredEntities,
    showSearchField,
    searchQuery,
    selectedEntityId,
    sortIndex,
  ];
}
