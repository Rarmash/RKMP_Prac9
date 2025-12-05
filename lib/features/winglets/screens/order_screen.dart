import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/data_service.dart';

class OrderScreen extends StatefulWidget {
  final DataService dataService;
  const OrderScreen({super.key, required this.dataService});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int? selectedId;
  final TextEditingController quantityController = TextEditingController();
  String? errorMessage;

  void _makeOrder() {
    if (selectedId == null) return;
    final int quantity = int.tryParse(quantityController.text) ?? 0;
    if (quantity <= 0) return;

    final product = widget.dataService.findById(selectedId!);
    if (product == null) return;

    final success = widget.dataService.updateQuantity(product.id, quantity);

    if (!success) {
      setState(() {
        errorMessage =
        'На складе доступно только ${product.quantity} шт. Вы не можете заказать больше.';
      });
      return;
    }

    final order = {
      'id': product.id,
      'name': product.name,
      'quantity': quantity,
      'date': DateTime.now(),
    };

    context.push('/cart', extra: order);
  }

  @override
  Widget build(BuildContext context) {
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
              isExpanded: true,
              hint: const Text('Выберите товар'),
              value: selectedId,
              items: widget.dataService.products.map((p) {
                return DropdownMenuItem<int>(
                  value: p.id,
                  child: Text('${p.name} (остаток: ${p.quantity})'),
                );
              }).toList(),
              onChanged: (value) => setState(() {
                selectedId = value;
                errorMessage = null;
              }),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Количество',
                border: OutlineInputBorder(),
              ),
            ),
            if (errorMessage != null) ...[
              const SizedBox(height: 10),
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _makeOrder,
              child: const Text('Оформить заказ'),
            ),
          ],
        ),
      ),
    );
  }
}
