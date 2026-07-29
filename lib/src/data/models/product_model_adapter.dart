import 'package:hive/hive.dart';

import 'product_model.dart';

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 0;

  @override
  ProductModel read(BinaryReader reader) {
    // Matches hive_generator's binary format:
    //   [numberOfFields: byte] ([fieldIndex: byte] [value: generic])...
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      id: fields[0] as String,
      productName: fields[1] as String,
      productSKU: fields[2] as String,
      purchasePrice: (fields[3] as num).toDouble(),
      sellingPrice: (fields[4] as num).toDouble(),
      initialQuantity: fields[5] as int,
      quantityPerPackage: fields[6] as int,
      productImage: fields[7] as String?,
      createdAt: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    // Matches hive_generator's binary format:
    //   [numberOfFields: byte] ([fieldIndex: byte] [value: generic])...
    writer.writeByte(9);
    writer.writeByte(0);
    writer.write(obj.id);
    writer.writeByte(1);
    writer.write(obj.productName);
    writer.writeByte(2);
    writer.write(obj.productSKU);
    writer.writeByte(3);
    writer.write(obj.purchasePrice);
    writer.writeByte(4);
    writer.write(obj.sellingPrice);
    writer.writeByte(5);
    writer.write(obj.initialQuantity);
    writer.writeByte(6);
    writer.write(obj.quantityPerPackage);
    writer.writeByte(7);
    writer.write(obj.productImage);
    writer.writeByte(8);
    writer.write(obj.createdAt);
  }
}
