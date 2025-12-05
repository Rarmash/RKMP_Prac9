import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/winglet_provider.dart';
import '../widgets/product_tile.dart';
import '../services/data_service.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late DataService data;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    data = WingletProvider.of(context).dataService;
  }

  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Каталог подкрылков')),
      body: ListView.builder(
        itemCount: data.products.length,
        itemBuilder: (context, index) {
          return ProductTile(product: data.products[index]);
        },
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
                onPressed: () async {
                  await context.push('/order');
                  _refresh();
                },
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.inventory),
                label: const Text('Склад'),
                onPressed: () async {
                  await context.push('/stock');
                  _refresh();
                },
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
