import 'package:kml_library/src/domain/model/library.dart';

abstract class IGetLibraryUseCase {
  Future<Library> execute();
}
