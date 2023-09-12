import 'package:kml_library/src/domain/model/collection.dart';
import 'package:kml_library/src/domain/model/place_marker.dart';

abstract class ILoadCollectionUseCase {
  Future<Collection> execute(
    final String name,
    final List<PlaceMarker> placeMarkers,
  );
}
