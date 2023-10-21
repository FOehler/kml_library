import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kml_library/src/domain/model/collection_id.dart';
import 'package:kml_library/src/domain/model/place_marker.dart';

part 'collection.freezed.dart';

@unfreezed
class Collection with _$Collection {
  factory Collection({
    required CollectionId id,
    required String name,
    required String icon,
    required List<PlaceMarker> placeMarkers,
  }) = _Collection;
}
