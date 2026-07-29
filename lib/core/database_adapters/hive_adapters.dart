import 'package:hive_flutter/hive_flutter.dart';
import 'package:trucky/src/data/models/product_model.dart';
import 'package:trucky/src/data/models/product_model_adapter.dart';
import 'package:trucky/src/data/models/product_transaction_model.dart';

/// Centralises all Hive adapter registrations & box pre-opening.
///
/// Call once from `main()` before `configureDependencies()`.
Future<void> initHive() async {
  await Hive.initFlutter();

  // ── Register adapters ──────────────────────────────────────────

  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(ProductTransactionModelAdapter());

  // ── Open boxes (add new ones here as your app grows) ───────────

  await Hive.openBox<ProductModel>(_BoxNames.products);
  await Hive.openBox<ProductTransactionModel>(_BoxNames.productTransactions);
}

class _BoxNames {
  static const String products = 'products';
  static const String productTransactions = 'product_transactions';
}
