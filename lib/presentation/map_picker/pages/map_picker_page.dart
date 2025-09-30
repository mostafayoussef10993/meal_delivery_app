import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPickerPage extends StatefulWidget {
  const MapPickerPage({super.key});

  @override
  State<MapPickerPage> createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {
  LatLng _pickedLocation = const LatLng(30.0444, 31.2357); // Default Cairo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pick Delivery Location")),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _pickedLocation,
              zoom: 15,
            ),
            onTap: (pos) {
              setState(() {
                _pickedLocation = pos;
              });
            },
            markers: {
              Marker(
                markerId: const MarkerId("selected"),
                position: _pickedLocation,
              ),
            },
          ),
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _pickedLocation);
              },
              child: const Text("Select Location"),
            ),
          ),
        ],
      ),
    );
  }
}
