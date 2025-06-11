import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ConfigProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  Locale currentLanguage = const Locale('en');

  bool get isLight => currentTheme == ThemeMode.light;
  bool get isEnglish => currentLanguage.languageCode == 'en';

  void changeAppTheme(ThemeMode newTheme) {
    if (newTheme == currentTheme) {
      return;
    }
    currentTheme = newTheme;
    notifyListeners();
  }

  void changeAppLanguage(Locale newLanguage) {
    if (newLanguage == currentLanguage) {
      return;
    }
    currentLanguage = newLanguage;
    notifyListeners();
  }

  Location location = Location();
  String locationMessage = 'check location';

  Future<void> getLocation() async {
    bool isPermissionEnabled = await _checkPermission();
    if (!isPermissionEnabled) {
      locationMessage = 'check permission denied';
      notifyListeners();
      return;
    }
    bool isServiceEnabled = await _checkService();
    if (!isServiceEnabled) {
      locationMessage = 'check service locator denied';
      notifyListeners();
      return;
    }

    LocationData myLocation = await location.getLocation();
    goToLocation(
      LatLng(myLocation.latitude ?? 0, myLocation.longitude ?? 0),
    );
    notifyListeners();
  }

  Future<bool> _checkPermission() async {
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> _checkService() async {
    bool isServiceEnabled = await location.serviceEnabled();

    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
    }
    return isServiceEnabled;
  }

  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(30.098008102245288, 31.245393501046134),
    zoom: 13,
  );

  Set<Marker> markers = {};

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


  
}
