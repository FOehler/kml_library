import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kml_library/src/domain/model/place_marker_id.dart';

part 'place_marker.freezed.dart';

@freezed
class PlaceMarker with _$PlaceMarker {
  const factory PlaceMarker({
    required PlaceMarkerId id,
    required String name,
    required String description,
    required String icon,
    required int color,
    required double xCoordinate,
    required double yCoordinate,
  }) = _PlaceMarker;

  const PlaceMarker._();
}
