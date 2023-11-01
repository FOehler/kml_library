import 'package:flutter/material.dart';
import 'package:kml_library/src/domain/model/place_marker.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MarkerDetailPage extends StatelessWidget {
  final PlaceMarker placeMarker;
  const MarkerDetailPage({Key? key, required this.placeMarker})
      : super(key: key);

  final thunderforestKey = const String.fromEnvironment('THUNDERFOREST_KEY');

  @override
  Widget build(BuildContext context) {
    if (thunderforestKey.isEmpty) {
      throw AssertionError('THUNDERFOREST_KEY is not set');
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(placeMarker.name),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Text(placeMarker.description),
              Expanded(
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(
                        placeMarker.yCoordinate, placeMarker.xCoordinate),
                    initialZoom: 10,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.thunderforest.com/atlas/{z}/{x}/{y}.png?apikey=$thunderforestKey',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(
                              placeMarker.yCoordinate, placeMarker.xCoordinate),
                          width: 80,
                          height: 80,
                          child: Icon(Icons.place,
                              color: Color(placeMarker.color)),
                        ),
                      ],
                    ),
                    RichAttributionWidget(
                      attributions: [
                        TextSourceAttribution(
                          'OpenStreetMap contributors',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
