/// Enum to differentiate between Client and Supplier
enum EntityType { client, supplier, none }

/// Operation type for add/edit
enum OperationType { add, edit }

/// Payment type for filtering transactions
enum PaymentType { all, sale, payment, returnn, refund, purchase }

/// Sort type for sorting lists
enum SortType {
  none,
  ascending,
  descending,
  highToLow,
  lowToHigh,
  newestFirst,
  oldestFirst,
}

/// Transaction type for sale/purchase vs return
enum TransactionType { sale, returnTransaction }
