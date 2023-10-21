import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kml_library/src/domain/domain_module.dart';
import 'package:kml_library/src/domain/model/collection_id.dart';
import 'package:kml_library/src/domain/model/library.dart';
import 'package:kml_library/src/domain/usecases/i_delete_collection_usecase.dart';
import 'package:kml_library/src/domain/usecases/i_get_library_usecase.dart';
import 'package:kml_library/src/domain/usecases/i_import_mymaps_collection_usecase.dart';
import 'package:kml_library/src/presentation/state/state.dart';

final libraryNotifierProvider =
    StateNotifierProvider<LibraryNotifier, State<Library>>((ref) {
  final getLibraryUseCase = ref.watch(getLibraryUseCaseProvider);
  final importMyMapsCollectionUseCase =
      ref.watch(importMyMapsCollectionUseCaseProvider);
  final deleteCollectionUseCase = ref.watch(deleteCollectionUseCaseProvider);
  return LibraryNotifier(getLibraryUseCase, importMyMapsCollectionUseCase,
      deleteCollectionUseCase);
});

class LibraryNotifier extends StateNotifier<State<Library>> {
  final IGetLibraryUseCase _getLibraryUseCase;
  final IImportMyMapsCollectionUseCase _importMyMapsCollectionUseCase;
  final IDeleteCollectionUseCase _deleteCollectionUseCase;

  LibraryNotifier(this._getLibraryUseCase, this._importMyMapsCollectionUseCase,
      this._deleteCollectionUseCase)
      : super(const State.init()) {
    getLibrary();
  }

  getLibrary() async {
    try {
      Library library = await _getLibraryUseCase.execute();
      state = State.success(library);
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  importMyMapsCollection(final String path) async {
    try {
      const State.loading();
      await _importMyMapsCollectionUseCase.execute(path);
      Library library = await _getLibraryUseCase.execute();
      state = State.success(library);
    } on Exception catch (e) {
      state = State.error(e);
      return Future.value(null);
    }
  }

  deleteCollection(final CollectionId collectionId) async {
    try {
      const State.loading();
      await _deleteCollectionUseCase.execute(collectionId);
      Library library = await _getLibraryUseCase.execute();
      state = State.success(library);
    } on Exception catch (e) {
      state = State.error(e);
      return Future.value(null);
    }
  }
}
