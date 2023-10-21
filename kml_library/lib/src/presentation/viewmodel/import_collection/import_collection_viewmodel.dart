import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:kml_library/src/presentation/viewmodel/collection_list/libraryNotifierProvider.dart';

final importCollectionViewModelProvider = Provider.autoDispose((ref) {
  return ImportCollectionViewModel(ref.watch(libraryNotifierProvider.notifier));
});

class ImportCollectionViewModel {
  final LibraryNotifier _libraryNotifier;

  ImportCollectionViewModel(this._libraryNotifier) {}

  importMyMapsCollection() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _libraryNotifier.importMyMapsCollection(result.files.single.path!);
    } else {
      // User canceled the picker
      return Future.value(null);
    }
  }
}
