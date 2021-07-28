import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMapsView extends StatefulWidget {
  const MyMapsView({Key? key}) : super(key: key);

  @override
  _MyMapsViewState createState() => _MyMapsViewState();
}

class _MyMapsViewState extends State<MyMapsView> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(-6.905977, 107.613144);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 11.0,
      ),
    );
  }
}
