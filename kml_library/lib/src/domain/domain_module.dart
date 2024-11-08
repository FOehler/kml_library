import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kml_library/src/data/data_module.dart';
import 'package:kml_library/src/domain/usecases/delete_collection_usecase.dart';
import 'package:kml_library/src/domain/usecases/i_delete_collection_usecase.dart';
import 'package:kml_library/src/domain/usecases/i_get_library_usecase.dart';
import 'package:kml_library/src/domain/usecases/get_library_usecase.dart';
import 'package:kml_library/src/domain/usecases/i_import_mymaps_collection_usecase.dart';
import 'package:kml_library/src/domain/usecases/i_rename_collection_usecase.dart';
import 'package:kml_library/src/domain/usecases/import_mymaps_collection_usecase.dart';
import 'package:kml_library/src/domain/usecases/rename_collection_usecase.dart';

final getLibraryUseCaseProvider = Provider<IGetLibraryUseCase>(
    (ref) => GetLibraryUseCase(ref.watch(libraryRepositoryProvider)));
final importMyMapsCollectionUseCaseProvider =
    Provider<IImportMyMapsCollectionUseCase>((ref) =>
        ImportMyMapsCollectionUseCase(ref.watch(libraryRepositoryProvider)));
final deleteCollectionUseCaseProvider = Provider<IDeleteCollectionUseCase>(
    (ref) => DeleteCollectionUseCase(ref.watch(libraryRepositoryProvider)));
final renameCollectionUseCaseProvider = Provider<IRenameCollectionUseCase>(
    (ref) => RenameCollectionUseCase(ref.watch(libraryRepositoryProvider)));
