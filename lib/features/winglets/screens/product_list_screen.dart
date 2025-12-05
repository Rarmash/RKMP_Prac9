import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/product_list_provider.dart';
import '../widgets/product_tile.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Каталог подкрылков')),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) =>
            ProductTile(product: products[index]),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Заказ'),
                onPressed: () => context.push('/order'),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.inventory),
                label: const Text('Склад'),
                onPressed: () => context.push('/stock'),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.history),
                label: const Text('История'),
                onPressed: () => context.push('/history'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
