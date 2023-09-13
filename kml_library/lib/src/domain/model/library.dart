import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kml_library/src/domain/model/collection.dart';

part 'library.freezed.dart';

@freezed
class Library with _$Library {
  const factory Library({
    required List<Collection> collections,
  }) = _Library;

  Collection operator [](final int index) => collections[index];

  int get length => collections.length;

  const Library._();
}
