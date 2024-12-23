import 'package:kml_library/src/data/entity/collection_entity.dart';
import 'package:kml_library/src/data/mapper/collection_mapper.dart';
import 'package:kml_library/src/domain/model/collection.dart';
import 'package:kml_library/src/domain/model/collection_id.dart';
import 'package:kml_library/src/domain/model/library.dart';
import 'package:kml_library/src/domain/respository/i_library_repository.dart';
import '../datasource/i_library_database.dart';

class LibraryRepository implements ILibraryRepository {
  final ILibraryDatabase database;

  const LibraryRepository(this.database);

  @override
  Future<Collection> addCollection(Collection collection) async {
    await database
        .addCollection(CollectionMapper.transformToEntity(collection));
    return collection;
  }

  @override
  Future<void> deleteCollection(CollectionId id) {
    return database.deleteCollection(id.value);
  }

  @override
  Future<Library> getLibrary() async {
    List<CollectionEntity> collections = await database.getLibrary();
    return Library(
        collections: collections
            .map((c) => CollectionMapper.transformToModel(c))
            .toList());
  }

  @override
  Future<Collection> renameCollection(CollectionId id, String newName) async {
    CollectionEntity entity =
        await database.renameCollection(id.value, newName);
    return CollectionMapper.transformToModel(entity);
  }
}
