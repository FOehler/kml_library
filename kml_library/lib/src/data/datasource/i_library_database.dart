import 'package:kml_library/src/data/entity/collection_entity.dart';

abstract class ILibraryDatabase {
  Future<List<CollectionEntity>> getLibrary();

  Future addCollection(CollectionEntity collection);

  Future deleteCollection(int collectionId);

  Future<CollectionEntity> renameCollection(int collectionId, String newName);
}
