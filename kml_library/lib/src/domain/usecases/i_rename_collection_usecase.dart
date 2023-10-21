import 'package:kml_library/src/domain/model/collection.dart';
import 'package:kml_library/src/domain/model/collection_id.dart';

abstract class IRenameCollectionUseCase {
  Future<Collection> execute(final CollectionId id, final String newName);
}
