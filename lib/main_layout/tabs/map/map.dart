import 'package:evently_app/providers/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Maptab extends StatefulWidget {
  const Maptab({super.key});

  @override
  State<Maptab> createState() => _MaptabState();
}

class _MaptabState extends State<Maptab> {
  late ConfigProvider mainProvider;
  @override
  void initState() {
    super.initState();
    mainProvider = Provider.of<ConfigProvider>(context, listen: false);
    mainProvider.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConfigProvider>(
      builder: (context, provider, child) => GoogleMap(
        onMapCreated: (controller) {
          provider.googleMapController = controller;
        },
        onTap: (latLng) {
          provider.goToLocation(latLng);
        },
        initialCameraPosition: provider.initialCameraPosition,
        mapType: MapType.normal,
        markers: provider.markers,
      ),
    );
  }
}
