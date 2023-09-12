import 'package:freezed_annotation/freezed_annotation.dart';

part 'collection_id.freezed.dart';

@freezed
class CollectionId with _$CollectionId {
  const factory CollectionId({
    required int value,
  }) = _CollectionId;
}
