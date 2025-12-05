import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/product.dart';

part 'product_list_provider.g.dart';

@riverpod
class ProductList extends _$ProductList {
  @override
  List<Product> build() {
    return const [
      Product(id: 1, name: 'Передний подкрылок', quantity: 20),
      Product(id: 2, name: 'Задний подкрылок', quantity: 15),
      Product(id: 3, name: 'Левый подкрылок', quantity: 10),
      Product(id: 4, name: 'Правый подкрылок', quantity: 8),
      Product(id: 5, name: 'Комплект подкрылков', quantity: 5),
    ];
  }

  Product? _findById(int id) {
    try {
      return state.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  void order(int id, int qty) {
    final product = _findById(id);
    if (product == null) return;
    if (qty <= 0 || qty > product.quantity) return;

    state = [
      for (final p in state)
        if (p.id == id) p.copyWith(quantity: p.quantity - qty) else p,
    ];
  }

  void restock(int id, int qty) {
    if (qty <= 0) return;

    state = [
      for (final p in state)
        if (p.id == id) p.copyWith(quantity: p.quantity + qty) else p,
    ];
  }

  void addOrRestock(String name, int qty) {
    final exists = state.any(
          (p) => p.name.toLowerCase() == name.toLowerCase(),
    );

    if (exists) {
      final product = state.firstWhere(
            (p) => p.name.toLowerCase() == name.toLowerCase(),
      );
      restock(product.id, qty);
    } else {
      final newId =
      state.isEmpty ? 1 : state.map((p) => p.id).reduce((a, b) => a > b ? a : b) + 1;

      state = [
        ...state,
        Product(id: newId, name: name, quantity: qty),
      ];
    }
  }

  void removeProduct(int id) {
    state = state.where((p) => p.id != id).toList();
  }
}
