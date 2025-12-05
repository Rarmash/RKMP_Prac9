import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_provider.g.dart';

@Riverpod(keepAlive: true)
class CartState extends _$CartState {
  @override
  Map<String, dynamic>? build() => null;

  void setOrder(Map<String, dynamic> order) {
    state = order;
  }

  void clear() {
    state = null;
  }
}
