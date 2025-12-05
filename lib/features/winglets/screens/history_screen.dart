import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/history_provider.dart';
import '../../../utils/format_utils.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(orderHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('История заказов'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: history.isEmpty
          ? const Center(child: Text('История пуста'))
          : ListView.builder(
        itemCount: history.length,
        itemBuilder: (_, i) {
          final item = history[i];
          return ListTile(
            title: Text(item['name']),
            subtitle: Text(
              'Кол-во: ${item['quantity']} • ${formatDate(item['date'])}',
            ),
            leading: const Icon(Icons.check_circle, color: Colors.green),
          );
        },
      ),
    );
  }
}
