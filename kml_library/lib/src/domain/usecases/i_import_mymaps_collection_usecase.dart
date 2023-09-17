import 'package:kml_library/src/domain/model/collection.dart';

abstract class IImportMyMapsCollectionUseCase {
  Future<Collection> execute(final String path);
}
