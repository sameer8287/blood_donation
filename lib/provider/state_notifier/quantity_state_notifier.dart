

import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuantityNotifier extends StateNotifier<int> {
  QuantityNotifier(): super(0);
  int quantity =0;
  void add(int value)
  {
    state = value;

    quantity = value;
  }

  void subtract(int value)
  {
    state = value;
    quantity = value;
  }
  
}

final quantityProvider = StateNotifierProvider<QuantityNotifier,int>((ref) => QuantityNotifier());