import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SetLocationProvider extends ChangeNotifier {
  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(30.098016390490695, 31.2454222407975),
    zoom: 13,
  );

  Set<Marker> markers = {
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(30.098016390490695, 31.2454222407975),
    ),
  };

  late GoogleMapController googleMapController;

  void goToLocation(LatLng location) {
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(location.latitude, location.longitude),
          zoom: 13,
        ),
      ),
    );
    markers = {
      Marker(
        markerId: const MarkerId('1'),
        position: LatLng(location.latitude, location.longitude),
      ),
    };
    notifyListeners();
  }

  LatLng? selectedLocation;
  changeSelectedLocation(LatLng location) {
    selectedLocation = location;
    goToLocation(location);
    notifyListeners();
  }
}
