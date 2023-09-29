import 'dart:io';

import 'package:kml_library/src/domain/logic/parsers/i_parser.dart';
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
    IParser parser;
    File file = File(path);
    if (path.endsWith("kmz")) {
      parser = MyMapsKmzFileParser(file);
    } else {
      parser = MyMapsKmlFileParser(file);
    }

    Collection collection = await parser.parse();
    _repository.addCollection(collection);
    return collection;
  }
}
