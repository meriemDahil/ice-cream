import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MapIntegration extends StatefulWidget {
  @override
  _MapIntegrationState createState() => _MapIntegrationState();
}

class _MapIntegrationState extends State<MapIntegration> {
  final cacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 30),
      maxNrOfCacheObjects: 200,
    ),
  );

  final Map<String, bool> _cacheStatus = {};

  void _updateCacheStatus(String url, bool isCached) {
    setState(() {
      _cacheStatus[url] = isCached;
      print(_cacheStatus.values.where((cached) => cached).length);
   
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(28.026876 ,1.65284), // alger
        initialZoom: 13.0,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          tileProvider: TileProviderWithCacheStatus(
            cacheManager: cacheManager,
            cacheStatusCallback: _updateCacheStatus,
          ),
        ),
        if (_cacheStatus.isNotEmpty)
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Tiles Cached: ${_cacheStatus.values.where((cached) => cached).length}',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
      ],
    );
  }
}

class TileProviderWithCacheStatus extends TileProvider {
  final CacheManager cacheManager;
  final Function(String, bool) cacheStatusCallback;

  TileProviderWithCacheStatus({
    required this.cacheManager,
    required this.cacheStatusCallback,
  });

  @override
  ImageProvider getImage(TileCoordinates coordinates, TileLayer options) {
    final url = getTileUrl(coordinates, options);
    return _getCachedImageProvider(url);
  }

  @override
  String getTileUrl(TileCoordinates coordinates, TileLayer options) {
    final urlTemplate = options.urlTemplate;
    final tileUrl = urlTemplate!
       
        .replaceAll('{z}', coordinates.z.toString())
        .replaceAll('{x}', coordinates.x.toString())
        .replaceAll('{y}', coordinates.y.toString());
    return tileUrl;
  }

  ImageProvider _getCachedImageProvider(String url) {
    cacheManager.getFileFromCache(url).then((fileInfo) {
      bool isCached = fileInfo != null && fileInfo.file.existsSync();
      cacheStatusCallback(url, isCached);
    });

    return CachedNetworkImageProvider(url, cacheManager: cacheManager);
  }
}