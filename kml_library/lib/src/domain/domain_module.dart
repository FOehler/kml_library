import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kml_library/src/data/data_module.dart';
import 'package:kml_library/src/domain/usecases/i_get_library_usecase.dart';
import 'package:kml_library/src/domain/usecases/get_library_usecase.dart';

final getLibraryUseCaseProvider =
    Provider<IGetLibraryUseCase>((ref) => GetLibraryUseCase(ref.watch(libraryRepositoryProvider)));
