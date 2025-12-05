import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'product_list_provider.dart';

part 'stock_provider.g.dart';

@riverpod
class StockManager extends _$StockManager {
  @override
  void build() {}

  void restock(ref, int id, int qty) {
    ref.read(productListProvider.notifier).restock(id, qty);
  }
}