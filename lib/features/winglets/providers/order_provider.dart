import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentOrder extends _$CurrentOrder {
  @override
  Map<String, dynamic>? build() => null;

  void createOrder(Map<String, dynamic> data) {
    state = data;
  }

  void clear() {
    state = null;
  }
}
