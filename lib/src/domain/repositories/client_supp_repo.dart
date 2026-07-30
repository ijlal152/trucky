import '../../../core/constants/enums.dart';
import '../entities/client_supp_entity.dart';

/// Domain contract for client/supplier operations.
abstract class ClientSuppRepo {
  /// Fetch all contacts of the given [entityType].
  Future<List<ClientSuppEntity>> getAll({required EntityType entityType});

  /// Add a new contact; returns the created entity (with generated id).
  Future<ClientSuppEntity> add({required ClientSuppEntity contact});

  /// Delete a contact by [id].
  Future<void> delete({required String id});

  /// Update an existing contact.
  Future<ClientSuppEntity> update({required ClientSuppEntity contact});
}
