import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/cart_provider.dart';
import '../../../utils/format_utils.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(cartStateProvider);

    if (order == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Результат заказа'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pushReplacement('/products'),
          ),
        ),
        body: const Center(child: Text('Нет данных для отображения')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Результат заказа'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(cartStateProvider.notifier).clear();
            context.pushReplacement('/products');
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Заказ успешно оформлен!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text('Товар: ${order['name']}',
                  style: const TextStyle(fontSize: 18)),
              Text('Количество: ${order['quantity']}',
                  style: const TextStyle(fontSize: 18)),
              Text('Дата: ${formatDate(order['date'])}',
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
