// presentation/delivery/widgets/card_info_fields.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/presentation/delivery/bloc/delivery_cubit.dart';

class CardInfoFields extends StatelessWidget {
  const CardInfoFields({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DeliveryCubit>();
    final state = cubit.state;

    if (!state.payWithCard) return const SizedBox.shrink();

    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(labelText: "Card Name"),
          onChanged: cubit.setCardName,
        ),
        const SizedBox(height: 12),
        TextField(
          decoration: const InputDecoration(labelText: "Card Number"),
          keyboardType: TextInputType.number,
          onChanged: cubit.setCardNumber,
        ),
        const SizedBox(height: 12),
        TextField(
          decoration: const InputDecoration(labelText: "CVC"),
          keyboardType: TextInputType.number,
          onChanged: cubit.setCvc,
        ),
      ],
    );
  }
}
