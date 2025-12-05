import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/product_list_provider.dart';
import '../providers/history_provider.dart';
import '../providers/cart_provider.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key});

  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  int? selectedId;
  final qtyController = TextEditingController();
  String? error;

  void _submit() {
    final qty = int.tryParse(qtyController.text) ?? 0;
    if (selectedId == null || qty <= 0) return;

    final products = ref.read(productListProvider);
    final p = products.firstWhere((x) => x.id == selectedId);

    if (qty > p.quantity) {
      setState(() => error = 'Доступно только ${p.quantity} шт.');
      return;
    }

    ref.read(productListProvider.notifier).order(p.id, qty);

    final order = {
      'id': p.id,
      'name': p.name,
      'quantity': qty,
      'date': DateTime.now(),
    };

    ref.read(orderHistoryProvider.notifier).add(order);

    ref.read(cartStateProvider.notifier).setOrder(order);

    context.push('/cart');
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Оформление заказа'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<int>(
              value: selectedId,
              hint: const Text('Выберите товар'),
              isExpanded: true,
              items: products.map((p) {
                return DropdownMenuItem(
                  value: p.id,
                  child: Text('${p.name} (остаток: ${p.quantity})'),
                );
              }).toList(),
              onChanged: (v) {
                setState(() {
                  selectedId = v;
                  error = null;
                });
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: qtyController,
              decoration: const InputDecoration(
                labelText: 'Количество',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(error!, style: const TextStyle(color: Colors.red)),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Оформить'),
            ),
          ],
        ),
      ),
    );
  }
}
