import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kml_library/src/domain/domain_module.dart';
import 'package:kml_library/src/domain/model/collection_id.dart';
import 'package:kml_library/src/domain/usecases/i_delete_collection_usecase.dart';
import 'package:kml_library/src/presentation/viewmodel/collection_list/libraryNotifierProvider.dart';

final collectionSettingsViewModelProvider = Provider.autoDispose((ref) {
  return CollectionSettingsViewModel(
    ref.watch(libraryNotifierProvider.notifier),
  );
});

class CollectionSettingsViewModel {
  final LibraryNotifier _libraryNotifier;

  CollectionSettingsViewModel(this._libraryNotifier);

  deleteCollection(final CollectionId collectionId) async {
    _libraryNotifier.deleteCollection(collectionId);
  }
}
