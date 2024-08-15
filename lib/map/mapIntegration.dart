
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapIntegration extends StatefulWidget {
  @override
  State<MapIntegration> createState() => _MapIntegrationState();
}

class _MapIntegrationState extends State<MapIntegration> {
  final String apiKey = '';
  Dio dio =Dio();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MapTiler with Flutter MAP')),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(36.7965083, 2.9337917), 
          initialZoom: 13.0,
        ),
        children: [
         
          TileLayer(
            urlTemplate:
                'https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=$apiKey',
            additionalOptions: {
              'key': apiKey,
            },
          ),
        ], 
      ),
    );
  }
}
