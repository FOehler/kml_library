import 'package:kml_library/src/domain/model/collection.dart';
import 'package:kml_library/src/domain/model/collection_id.dart';
import 'package:kml_library/src/domain/respository/i_library_repository.dart';
import 'package:kml_library/src/domain/usecases/i_rename_collection_usecase.dart';

class RenameCollectionUseCase implements IRenameCollectionUseCase {
  final ILibraryRepository _repository;

  RenameCollectionUseCase(this._repository);

  @override
  Future<Collection> execute(CollectionId id, String newName) async {
    return await _repository.renameCollection(id, newName);
  }
}
