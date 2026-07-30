import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/enums.dart';
import 'app_routes.dart';

/// Extension on [BuildContext] to simplify client/supplier navigation.
extension ClientSuppNavigation on BuildContext {
  /// Navigate to the dashboard for the given [entityType].
  void goToClientSuppDashboard(EntityType entityType) {
    pushNamed(
      entityType == EntityType.client
          ? AppRoutes.clientDashboard.name
          : AppRoutes.supplierDashboard.name,
    );
  }

  /// Navigate to the add page for the given [entityType].
  void goToAddClientSupp(EntityType entityType) {
    pushNamed(
      entityType == EntityType.client
          ? AppRoutes.addClient.name
          : AppRoutes.addSupplier.name,
    );
  }
}
