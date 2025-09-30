// presentation/delivery/widgets/recipient_name_field.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/presentation/delivery/bloc/delivery_cubit.dart';

class RecipientNameField extends StatelessWidget {
  const RecipientNameField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(labelText: "Recipient Name"),
      onChanged: context.read<DeliveryCubit>().setName,
    );
  }
}
