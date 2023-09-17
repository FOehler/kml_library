import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kml_library/src/domain/domain_module.dart';
import 'package:kml_library/src/domain/usecases/i_import_mymaps_collection_usecase.dart';
import 'package:file_picker/file_picker.dart';

final importCollectionViewModelProvider = Provider.autoDispose((ref) {
  return ImportCollectionViewModel(ref.watch(importMyMapsCollectionUseCaseProvider));
});

class ImportCollectionViewModel {
  final IImportMyMapsCollectionUseCase _importMyMapsCollection;

  ImportCollectionViewModel(this._importMyMapsCollection) {}

  importMyMapsCollection() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _importMyMapsCollection.execute(result.files.single.path!);
    } else {
      // User canceled the picker
      return Future.value(null);
    }
  }
}
