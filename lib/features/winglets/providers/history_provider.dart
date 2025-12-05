import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_provider.g.dart';

@Riverpod(keepAlive: true)
class OrderHistory extends _$OrderHistory {
  @override
  List<Map<String, dynamic>> build() => [];

  void add(Map<String, dynamic> order) {
    state = [...state, order];
  }
}
