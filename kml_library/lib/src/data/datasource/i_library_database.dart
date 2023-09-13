import 'package:kml_library/src/data/entity/library_entity.dart';

abstract class ILibraryDatabase {
  Future<LibraryEntity> library();
}
