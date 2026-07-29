import 'package:hive/hive.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Transaction types for inventory movement tracking
// ─────────────────────────────────────────────────────────────────────────────
enum TransactionType { initialStock, purchase, sale, adjustment }

// ─────────────────────────────────────────────────────────────────────────────
// ProductTransactionModel — ledger entry for every stock movement
// ─────────────────────────────────────────────────────────────────────────────
@HiveType(typeId: 1)
class ProductTransactionModel extends HiveObject {
  @HiveField(0)
  final String id;

  /// FK → ProductModel.id
  @HiveField(1)
  final String productId;

  /// Type of transaction (initialStock / purchase / sale / adjustment)
  @HiveField(2)
  final String type;

  /// Positive = stock in, Negative = stock out
  @HiveField(3)
  final int quantity;

  /// Supplier or client ID (optional)
  @HiveField(4)
  final String? referenceId;

  /// Denormalised name of the supplier / client for display
  @HiveField(5)
  final String? referenceName;

  /// Unit price at the time of this transaction
  @HiveField(6)
  final double unitPrice;

  /// Total amount (quantity × unitPrice)
  @HiveField(7)
  final double totalAmount;

  @HiveField(8)
  final String? note;

  @HiveField(9)
  final DateTime date;

  ProductTransactionModel({
    required this.id,
    required this.productId,
    required this.type,
    required this.quantity,
    this.referenceId,
    this.referenceName,
    required this.unitPrice,
    required this.totalAmount,
    this.note,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  // ── Helpers ──────────────────────────────────────────────────────────────
  bool get isIncoming => type == 'initialStock' || type == 'purchase';
  bool get isOutgoing => type == 'sale';
  String get typeLabel {
    switch (type) {
      case 'initialStock':
        return 'Initial Stock';
      case 'purchase':
        return 'Purchase';
      case 'sale':
        return 'Sale';
      case 'adjustment':
        return 'Adjustment';
      default:
        return type;
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TypeAdapter for ProductTransactionModel (manual, mirrors hive_generator)
// ─────────────────────────────────────────────────────────────────────────────
class ProductTransactionModelAdapter
    extends TypeAdapter<ProductTransactionModel> {
  @override
  final int typeId = 1;

  @override
  ProductTransactionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductTransactionModel(
      id: fields[0] as String,
      productId: fields[1] as String,
      type: fields[2] as String,
      quantity: fields[3] as int,
      referenceId: fields[4] as String?,
      referenceName: fields[5] as String?,
      unitPrice: (fields[6] as num).toDouble(),
      totalAmount: (fields[7] as num).toDouble(),
      note: fields[8] as String?,
      date: fields[9] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ProductTransactionModel obj) {
    writer.writeByte(10);
    writer.writeByte(0);
    writer.write(obj.id);
    writer.writeByte(1);
    writer.write(obj.productId);
    writer.writeByte(2);
    writer.write(obj.type);
    writer.writeByte(3);
    writer.write(obj.quantity);
    writer.writeByte(4);
    writer.write(obj.referenceId);
    writer.writeByte(5);
    writer.write(obj.referenceName);
    writer.writeByte(6);
    writer.write(obj.unitPrice);
    writer.writeByte(7);
    writer.write(obj.totalAmount);
    writer.writeByte(8);
    writer.write(obj.note);
    writer.writeByte(9);
    writer.write(obj.date);
  }
}
