import 'package:go_router/go_router.dart';

import '../features/winglets/screens/cart_screen.dart';
import '../features/winglets/screens/history_screen.dart';
import '../features/winglets/screens/order_screen.dart';
import '../features/winglets/screens/product_list_screen.dart';
import '../features/winglets/screens/stock_manage_screen.dart';

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
      builder: (context, state) => const OrderScreen(),
    ),
    GoRoute(
      path: '/cart',
      name: 'cart',
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: '/stock',
      name: 'stock',
      builder: (context, state) => const StockManageScreen(),
    ),
    GoRoute(
      path: '/history',
      name: 'history',
      builder: (context, state) => const HistoryScreen(),
    ),
  ],
);
