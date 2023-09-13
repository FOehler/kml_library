import 'package:kml_library/src/domain/model/collection_id.dart';
import 'package:kml_library/src/domain/model/library.dart';
import 'package:kml_library/src/domain/model/place_marker.dart';
import 'package:kml_library/src/domain/respository/i_library_repository.dart';

class LibraryRepository implements ILibraryRepository {
  @override
  Future<void> addCollection(String name, List<PlaceMarker> placeMarkers) {
    // TODO: implement addCollection
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCollection(CollectionId id) {
    // TODO: implement deleteCollection
    throw UnimplementedError();
  }

  @override
  Future<Library> getLibrary() {
    // TODO: implement getLibrary
    throw UnimplementedError();
  }
}
