import 'package:kml_library/src/data/entity/collection_entity.dart';
import 'package:kml_library/src/domain/model/place_marker.dart';
import 'package:kml_library/src/domain/model/place_marker_id.dart';

class PlaceMarkerMapper {
  static PlaceMarkerEntity transformToEntity(PlaceMarker placeMarker) {
    PlaceMarkerEntity entity = PlaceMarkerEntity();
    entity.name = placeMarker.name;
    entity.color = placeMarker.color;
    entity.description = placeMarker.description;
    entity.xCoordinate = placeMarker.xCoordinate;
    entity.yCoordinate = placeMarker.yCoordinate;
    entity.icon = placeMarker.icon;
    return entity;
  }

  static PlaceMarker transformToModel(PlaceMarkerEntity placeMarkerEntity) {
    PlaceMarker placeMarker = PlaceMarker(
        id: PlaceMarkerId(value: 1),
        name: placeMarkerEntity.name!,
        color: placeMarkerEntity.color!,
        description: placeMarkerEntity.description!,
        xCoordinate: placeMarkerEntity.xCoordinate!,
        yCoordinate: placeMarkerEntity.yCoordinate!,
        icon: placeMarkerEntity.icon!);
    return placeMarker;
  }
}
