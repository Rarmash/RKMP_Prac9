import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/product_list_provider.dart';

class StockManageScreen extends ConsumerStatefulWidget {
  const StockManageScreen({super.key});

  @override
  ConsumerState<StockManageScreen> createState() => _StockManageScreenState();
}

class _StockManageScreenState extends ConsumerState<StockManageScreen> {
  final nameController = TextEditingController();
  final qtyController = TextEditingController();
  String? msg;

  void _submit() {
    final name = nameController.text.trim();
    final qty = int.tryParse(qtyController.text) ?? 0;

    if (name.isEmpty || qty <= 0) return;

    final exists = ref
        .read(productListProvider)
        .any((p) => p.name.toLowerCase() == name.toLowerCase());

    ref.read(productListProvider.notifier).addOrRestock(name, qty);

    setState(() {
      msg = exists
          ? 'Товар "$name" пополнен на $qty шт.'
          : 'Добавлен товар "$name" ($qty шт.)';
    });

    nameController.clear();
    qtyController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Управление складом'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Название товара'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: qtyController,
              decoration: const InputDecoration(labelText: 'Количество'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Добавить / Пополнить'),
            ),
            if (msg != null) ...[
              const SizedBox(height: 8),
              Text(msg!, style: const TextStyle(color: Colors.green)),
            ],
            const Divider(height: 25),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (_, i) => ListTile(
                  title: Text(products[i].name),
                  subtitle: Text('Количество: ${products[i].quantity}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => ref
                        .read(productListProvider.notifier)
                        .removeProduct(products[i].id),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
