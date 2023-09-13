import 'package:kml_library/src/domain/model/library.dart';
import 'package:kml_library/src/domain/respository/i_library_repository.dart';
import 'package:kml_library/src/domain/usecases/i_get_library_usecase.dart';

class GetLibraryUseCase implements IGetLibraryUseCase {
  final ILibraryRepository _repository;

  const GetLibraryUseCase(this._repository);

  @override
  Future<Library> execute() => _repository.getLibrary();
}
