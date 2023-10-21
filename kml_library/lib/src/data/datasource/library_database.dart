import 'package:isar/isar.dart';
import 'package:kml_library/src/data/datasource/i_library_database.dart';
import 'package:kml_library/src/data/entity/collection_entity.dart';
import 'package:path_provider/path_provider.dart';

class LibraryDatabase implements ILibraryDatabase {
  static Isar? _database;

  Future<Isar> get database async {
    if (_database == null) {
      final dir = await getApplicationDocumentsDirectory();
      _database = await Isar.open(
        [CollectionEntitySchema],
        directory: dir.path,
      );
    }
    return _database!;
  }

  @override
  Future<List<CollectionEntity>> getLibrary() async {
    final db = await database;
    return db.collectionEntitys.where().findAll();
  }

  @override
  Future addCollection(CollectionEntity collection) async {
    final db = await database;
    return db.writeTxn(() async {
      await db.collection<CollectionEntity>().put(collection);
    });
  }

  @override
  Future deleteCollection(int collectionId) async {
    final db = await database;
    return db.writeTxn(() async {
      return db.collectionEntitys.delete(collectionId);
    });
  }

  @override
  Future<CollectionEntity> renameCollection(
      int collectionId, String newName) async {
    final db = await database;
    CollectionEntity? collection = await db.collectionEntitys.get(collectionId);
    if (collection != null) {
      collection.name = newName;
      await db.writeTxn(() async {
        await db.collection<CollectionEntity>().put(collection);
      });
      return collection;
    } else {
      return CollectionEntity();
    }
  }
}
