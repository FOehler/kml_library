import 'package:kml_library/src/domain/model/collection.dart';
import 'package:kml_library/src/domain/model/collection_id.dart';
import 'package:kml_library/src/domain/model/library.dart';
import 'package:kml_library/src/domain/model/place_marker.dart';
import 'package:kml_library/src/domain/model/place_marker_id.dart';
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
    return Future.value(Library(collections: [
      Collection(
        id: const CollectionId(value: 1),
        name: "Iceland 2023",
        icon: "\u{1F1EE}\u{1F1F8}",
        placeMarkers: List.generate(
          23,
          (index) => PlaceMarker(
            id: PlaceMarkerId(value: index),
            name: "Ort $index",
            description: "Beschreibung $index",
            icon: "test",
            color: 1234,
            xCoordinate: 23.29494912,
            yCoordinate: 21.02834712,
          ),
        ),
      ),
      Collection(
        id: const CollectionId(value: 2),
        name: "Türkiye 2022",
        icon: "\u{1F1F9}\u{1F1F7}",
        placeMarkers: List.generate(
          34,
          (index) => PlaceMarker(
            id: PlaceMarkerId(value: index),
            name: "Ort $index",
            description: "Beschreibung $index",
            icon: "test",
            color: 1234,
            xCoordinate: 23.29494912,
            yCoordinate: 21.02834712,
          ),
        ),
      ),
      Collection(
        id: const CollectionId(value: 3),
        name: "Sakartvelo 2022",
        icon: "\u{1F1EC}\u{1F1EA}",
        placeMarkers: List.generate(
          12,
          (index) => PlaceMarker(
            id: PlaceMarkerId(value: index),
            name: "Ort $index",
            description: "Beschreibung $index",
            icon: "test",
            color: 1234,
            xCoordinate: 23.29494912,
            yCoordinate: 21.02834712,
          ),
        ),
      ),
    ]));
  }
}
