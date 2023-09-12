import 'package:kml_library/src/domain/model/collection_id.dart';
import 'package:kml_library/src/domain/model/library.dart';
import 'package:kml_library/src/domain/model/place_marker.dart';

abstract class LibraryRepository {
  Future<Library> getLibrary();

  Future<void> addCollection(
    final String name,
    final List<PlaceMarker> placeMarkers,
  );

  Future<void> deleteCollection(final CollectionId id);
}
