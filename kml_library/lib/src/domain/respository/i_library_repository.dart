import 'package:kml_library/src/domain/model/collection.dart';
import 'package:kml_library/src/domain/model/collection_id.dart';
import 'package:kml_library/src/domain/model/library.dart';

abstract class ILibraryRepository {
  Future<Library> getLibrary();

  Future<Collection> addCollection(Collection collection);

  Future<void> deleteCollection(final CollectionId id);
}
