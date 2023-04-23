import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressMapScreen extends StatefulWidget {
  const AddressMapScreen({Key? key, required this.latLng}) : super(key: key);

  final LatLng latLng;

  @override
  State<AddressMapScreen> createState() => _AddressMapScreenState();
}

class _AddressMapScreenState extends State<AddressMapScreen> {
  @override
  void initState() {
    super.initState();
    setLocation();
  }

  CameraPosition? initialCameraPosition;
  Set<Marker> markers = {};

  void setLocation() {
    initialCameraPosition = CameraPosition(target: widget.latLng, zoom: 12);
    markers.add(Marker(
      markerId: MarkerId('1'),
      position: widget.latLng,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        if (initialCameraPosition == null) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        return GoogleMap(
          initialCameraPosition: initialCameraPosition!,
          markers: markers,
        );
      }),
    );
  }
}
