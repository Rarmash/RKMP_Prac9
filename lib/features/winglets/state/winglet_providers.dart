import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/product.dart';

part 'winglet_providers.g.dart';

/// Список товаров (подкрылков) + операции над складом
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

  Product? _findByNameIgnoreCase(String name) {
    try {
      return state.firstWhere(
            (p) => p.name.toLowerCase() == name.toLowerCase(),
      );
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
        if (p.id == id)
          p.copyWith(quantity: p.quantity - qty)
        else
          p,
    ];
  }

  void restock(int id, int qty) {
    if (qty <= 0) return;

    state = [
      for (final p in state)
        if (p.id == id)
          p.copyWith(quantity: p.quantity + qty)
        else
          p,
    ];
  }

  void addOrRestockProduct(String name, int qty) {
    if (qty <= 0) return;

    final existing = _findByNameIgnoreCase(name);
    if (existing != null) {
      restock(existing.id, qty);
      return;
    }

    final newId = state.isEmpty
        ? 1
        : (state.map((p) => p.id).reduce((a, b) => a > b ? a : b) + 1);

    final newProduct = Product(id: newId, name: name, quantity: qty);
    state = [...state, newProduct];
  }

  void removeProduct(int id) {
    state = state.where((p) => p.id != id).toList();
  }
}
