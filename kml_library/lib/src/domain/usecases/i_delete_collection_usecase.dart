import 'package:kml_library/src/domain/model/collection_id.dart';

abstract class IDeleteCollection {
  Future<void> execute(final CollectionId id);
}
