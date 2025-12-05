import 'package:go_router/go_router.dart';
import '../features/winglets/screens/cart_screen.dart';
import '../features/winglets/screens/history_screen.dart';
import '../features/winglets/screens/order_screen.dart';
import '../features/winglets/screens/product_list_screen.dart';
import '../features/winglets/screens/stock_manage_screen.dart';
import '../features/winglets/services/data_service.dart';
import 'service_locator.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/products',
  routes: [
    GoRoute(
      path: '/products',
      name: 'products',
      builder: (context, state) => const ProductListScreen(),
    ),
    GoRoute(
      path: '/order',
      name: 'order',
      builder: (context, state) {
        final data = getIt<DataService>();
        return OrderScreen(dataService: data);
      },
    ),
    GoRoute(
      path: '/cart',
      name: 'cart',
      builder: (context, state) {
        final data = getIt<DataService>();
        final order =
            state.extra as Map<String, dynamic>? ?? <String, dynamic>{};
        return CartScreen(order: order, dataService: data);
      },
    ),
    GoRoute(
      path: '/stock',
      name: 'stock',
      builder: (context, state) {
        final data = getIt<DataService>();
        return StockManageScreen(dataService: data);
      },
    ),
    GoRoute(
      path: '/history',
      name: 'history',
      builder: (context, state) => const HistoryScreen(),
    ),
  ],
);