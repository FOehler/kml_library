import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kml_library/src/domain/model/collection_id.dart';
import 'package:kml_library/src/presentation/viewmodel/collection_list/library_notifier_provider.dart';

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

  renameCollection(
      final CollectionId collectionId, final String newName) async {
    _libraryNotifier.renameCollection(collectionId, newName);
  }
}
