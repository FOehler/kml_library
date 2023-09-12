import 'package:kml_library/src/domain/model/place_marker.dart';

class Collection {
  Collection(this.name, this.placeMarkers);

  final String name;
  final List<PlaceMarker> placeMarkers;
}
