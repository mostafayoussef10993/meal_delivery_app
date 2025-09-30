// presentation/delivery/widgets/payment_options.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/presentation/delivery/bloc/delivery_cubit.dart';

class PaymentOptions extends StatelessWidget {
  const PaymentOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DeliveryCubit>();
    final state = cubit.state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Payment Method", style: Theme.of(context).textTheme.titleMedium),
        Row(
          children: [
            Radio(
              value: false,
              groupValue: state.payWithCard,
              onChanged: (v) => cubit.setPayWithCard(false),
            ),
            const Text("Pay on delivery"),
            Radio(
              value: true,
              groupValue: state.payWithCard,
              onChanged: (v) => cubit.setPayWithCard(true),
            ),
            const Text("MasterCard"),
          ],
        ),
      ],
    );
  }
}
