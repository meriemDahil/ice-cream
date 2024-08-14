import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapIntegration extends StatefulWidget {
  const MapIntegration({super.key});

  @override
  State<MapIntegration> createState() => _MapIntegrationState();
}

class _MapIntegrationState extends State<MapIntegration> {
  @override
  Widget build(BuildContext context) {
    return  FlutterMap(
      options: MapOptions(initialCenter: LatLng( 1.2878, 103.8666),
      initialZoom:11,
      interactionOptions: InteractionOptions(flags: InteractiveFlag.doubleTapZoom),
      ),
      children: [
        openStreetMapTileLayer

      ],);
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
  urlTemplate:'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  userAgentPackageName:'dev.fleaflet.flutter_map.example'
  
);
