// presentation/delivery/widgets/address_field.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/presentation/delivery/bloc/delivery_cubit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:musicapp/presentation/map_picker/pages/map_picker_page.dart';

class AddressField extends StatelessWidget {
  const AddressField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DeliveryCubit>();
    final state = cubit.state;

    final controller = TextEditingController(text: state.address);

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: "Address"),
            onChanged: cubit.setAddress,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.map),
          onPressed: () async {
            final selectedLocation = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MapPickerPage()),
            );

            if (selectedLocation != null) {
              final lat = selectedLocation.latitude;
              final lng = selectedLocation.longitude;

              // Reverse Geocoding
              final placemarks = await placemarkFromCoordinates(lat, lng);
              if (placemarks.isNotEmpty) {
                final place = placemarks.first;
                final address =
                    "${place.street}, ${place.locality}, ${place.country}";
                cubit.setAddress(address);
                cubit.setLocation(lat, lng);
              }
            }
          },
        ),
      ],
    );
  }
}
