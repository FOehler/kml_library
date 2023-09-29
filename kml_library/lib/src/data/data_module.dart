import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kml_library/src/data/datasource/i_library_database.dart';
import 'package:kml_library/src/data/datasource/library_database.dart';
import 'package:kml_library/src/data/repository/library_repository.dart';
import 'package:kml_library/src/domain/respository/i_library_repository.dart';

final libraryDatabaseProvider = Provider<ILibraryDatabase>((_) => LibraryDatabase());
final libraryRepositoryProvider =
    Provider<ILibraryRepository>((ref) => LibraryRepository(ref.watch(libraryDatabaseProvider)));
