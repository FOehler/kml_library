import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_marker.freezed.dart';

@freezed
class PlaceMarker with _$PlaceMarker {
  const factory PlaceMarker({
    required String name,
    required String description,
    required String icon,
    required int color,
    required double xCoordinate,
    required double yCoordinate,
  }) = _PlaceMarker;

  const PlaceMarker._();
}
