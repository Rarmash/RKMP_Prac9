import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/service_locator.dart';
import '../services/data_service.dart';
import '../../../utils/format_utils.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DataService dataService = getIt<DataService>();
    final history = dataService.history;

    return Scaffold(
      appBar: AppBar(
        title: const Text('История заказов'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: history.isEmpty
          ? const Center(child: Text('История заказов пуста'))
          : ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          return ListTile(
            leading: const Icon(Icons.check_circle, color: Colors.green),
            title: Text(item['name']),
            subtitle: Text(
              'Количество: ${item['quantity']} • ${formatDate(item['date'])}',
            ),
          );
        },
      ),
    );
  }
}
