import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MapIntegration extends StatefulWidget {
  const MapIntegration({super.key});

  @override
  _MapIntegrationState createState() => _MapIntegrationState();
}

class _MapIntegrationState extends State<MapIntegration> {
  final cacheManager = CacheManager(
    Config(
      'customCacheKey', //  A unique key used to identify this cache.
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
      options: const MapOptions(
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
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Tiles Cached: ${_cacheStatus.values.where((cached) => cached).length}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
      ],
    );
  }
}

class TileProviderWithCacheStatus extends TileProvider {
  final CacheManager cacheManager; // CacheManager It manages downloading, storing, and retrieving cached files.
  final Function(String, bool) cacheStatusCallback; //A callback function that updates the UI with the caching status of a particular tile.(url: The URL of the tile,isCached indicating whether the tile is cached or not.)
 

  TileProviderWithCacheStatus({
    required this.cacheManager,
    required this.cacheStatusCallback,
  });

  @override
  ImageProvider getImage(TileCoordinates coordinates, TileLayer options) {
    final url = getTileUrl(coordinates, options);
    return _getCachedImageProvider(url);
  }

  //getTileUrl constructs the full URL for the tile by replacing the placeholders in the urlTemplate ({z}, {x}, {y}) with the actual values

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

    //CachedNetworkImageProvider   If the tile isn't cached, CachedNetworkImageProvider automatically downloads the image from the URL, if the tiles are already cached it will find them in the local cache and load them instantly, avoiding the need for another network download.
  }
}