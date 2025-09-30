// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/presentation/delivery/bloc/delivery_cubit.dart';
import 'package:musicapp/presentation/order_confirmation/pages/order_confirmation_page.dart';

class ConfirmPurchaseButton extends StatelessWidget {
  const ConfirmPurchaseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveryCubit, DeliveryState>(
      builder: (context, state) {
        final cubit = context.read<DeliveryCubit>();
        final isDisabled =
            state.name.isEmpty ||
            state.phone.isEmpty ||
            state.address.isEmpty ||
            (state.payWithCard &&
                (state.cardName.isEmpty ||
                    state.cardNumber.isEmpty ||
                    state.cvc.isEmpty));

        return SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: isDisabled
                ? null
                : () async {
                    await context.read<DeliveryCubit>().submit();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const OrderConfirmationPage(),
                      ),
                    );
                  },
            child: state.isSubmitting
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text("Confirm Purchase"),
          ),
        );
      },
    );
  }
}
