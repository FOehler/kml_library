import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kml_library/src/domain/model/place_marker.dart';

part 'collection.freezed.dart';

@freezed
class Collection with _$Collection {
  const factory Collection({
    required String name,
    required List<PlaceMarker> placeMarkers,
  }) = _Collection;

  const Collection._();
}
