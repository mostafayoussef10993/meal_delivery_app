// presentation/delivery/widgets/phone_field.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/presentation/delivery/bloc/delivery_cubit.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(labelText: "Phone Number"),
      keyboardType: TextInputType.phone,
      onChanged: context.read<DeliveryCubit>().setPhone,
    );
  }
}
