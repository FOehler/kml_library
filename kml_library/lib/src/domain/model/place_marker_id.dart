import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_marker_id.freezed.dart';

@freezed
class PlaceMarkerId with _$PlaceMarkerId {
  const factory PlaceMarkerId({
    required int value,
  }) = _PlaceMarkerId;
}
