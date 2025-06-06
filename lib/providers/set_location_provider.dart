import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SetLocationProvider extends ChangeNotifier {
  CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(30.008032773367237, 32.521857087633094),
    zoom: 13,
  );

  Set<Marker> markers = {
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(30.008032773367237, 32.521857087633094),
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
        markerId: MarkerId('1'),
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
