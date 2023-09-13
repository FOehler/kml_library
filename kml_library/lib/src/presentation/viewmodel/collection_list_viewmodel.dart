import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kml_library/src/domain/domain_module.dart';
import 'package:kml_library/src/domain/model/library.dart';
import 'package:kml_library/src/domain/usecases/i_get_library_usecase.dart';
import 'package:kml_library/src/presentation/state/state.dart';

final collectionListViewModelStateNotifierProvider =
    StateNotifierProvider.autoDispose<CollectionListViewModel, State<Library>>((ref) {
  return CollectionListViewModel(
    ref.watch(getLibraryUseCaseProvider),
  );
});

class CollectionListViewModel extends StateNotifier<State<Library>> {
  final IGetLibraryUseCase _getLibraryUseCase;

  CollectionListViewModel(this._getLibraryUseCase) : super(const State.init()) {
    _getLibrary();
  }

  _getLibrary() async {
    try {
      state = const State.loading();
      final todoList = await _getLibraryUseCase.execute();
      state = State.success(todoList);
    } on Exception catch (e) {
      state = State.error(e);
    }
  }
}
