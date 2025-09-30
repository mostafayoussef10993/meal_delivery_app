// ignore_for_file: avoid_print

import 'package:musicapp/data/models/delivery_info/delivery_info_model.dart';

class ProcessDeliveryUseCase {
  Future<void> call(DeliveryInfo info) async {
    // In real app, you can send this info to backend
    await Future.delayed(const Duration(seconds: 1)); // simulate API call
    print("Delivery info processed: ${info.toMap()}");
  }
}
