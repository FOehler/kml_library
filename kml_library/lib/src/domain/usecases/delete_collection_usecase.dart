import 'package:kml_library/src/domain/model/collection_id.dart';
import 'package:kml_library/src/domain/respository/i_library_repository.dart';
import 'package:kml_library/src/domain/usecases/i_delete_collection_usecase.dart';

class DeleteCollectionUseCase implements IDeleteCollectionUseCase {
  final ILibraryRepository _repository;

  const DeleteCollectionUseCase(this._repository);

  @override
  Future<void> execute(CollectionId id) => _repository.deleteCollection(id);
}
