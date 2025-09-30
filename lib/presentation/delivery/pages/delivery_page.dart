import 'package:flutter/material.dart';
import 'package:musicapp/common/widgets/address_field.dart';
import 'package:musicapp/common/widgets/button/confirm_purchase_button.dart';
import 'package:musicapp/common/widgets/card_info_fields.dart';
import 'package:musicapp/common/widgets/payment_options.dart';
import 'package:musicapp/common/widgets/phone_field.dart';
import 'package:musicapp/common/widgets/recipient_name_field.dart';

class DeliveryPage extends StatelessWidget {
  const DeliveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Delivery Info")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            RecipientNameField(),
            SizedBox(height: 12),
            PhoneField(),
            SizedBox(height: 12),
            AddressField(),
            SizedBox(height: 16),
            PaymentOptions(),
            SizedBox(height: 12),
            CardInfoFields(),
            SizedBox(height: 24),
            ConfirmPurchaseButton(),
          ],
        ),
      ),
    );
  }
}
