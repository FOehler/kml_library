import 'dart:io';

import 'package:kml_library/src/domain/logic/parsers/mymaps_kmz_file_parser.dart';
import 'package:kml_library/src/domain/logic/parsers/mymaps_kml_file_parser.dart';
import 'package:kml_library/src/domain/model/collection.dart';
import 'package:kml_library/src/domain/respository/i_library_repository.dart';
import 'package:kml_library/src/domain/usecases/i_import_mymaps_collection_usecase.dart';

class ImportMyMapsCollectionUseCase implements IImportMyMapsCollectionUseCase {
  final ILibraryRepository _repository;

  ImportMyMapsCollectionUseCase(this._repository);

  @override
  Future<Collection> execute(String path) async {
    if (path.endsWith("kmz")) {
      final zipFile = File(path);
      MyMapsKmzFileParser parser = MyMapsKmzFileParser(zipFile);
      // TODO: Store to repository
      return parser.parse();
    } else {
      File file = File(path);
      MyMapsKmlFileParser parser = MyMapsKmlFileParser(file);
      return parser.parse();
    }
  }
}
