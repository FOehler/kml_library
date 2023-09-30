import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kml_library/src/domain/domain_module.dart';
import 'package:kml_library/src/domain/model/collection_id.dart';
import 'package:kml_library/src/domain/usecases/i_delete_collection_usecase.dart';

final collectionSettingsViewModelProvider = Provider.autoDispose((ref) {
  return CollectionSettingsViewModel(
    ref.watch(deleteCollectionUseCaseProvider),
  );
});

class CollectionSettingsViewModel {
  final IDeleteCollectionUseCase _deleteCollectionUseCase;

  CollectionSettingsViewModel(this._deleteCollectionUseCase);

  deleteCollection(final CollectionId collectionId) async {
    _deleteCollectionUseCase.execute(collectionId);
  }
}
