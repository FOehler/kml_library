import 'package:kml_library/src/data/entity/collection_entity.dart';
import 'package:kml_library/src/data/mapper/place_marker_mapper.dart';
import 'package:kml_library/src/domain/model/collection.dart';
import 'package:kml_library/src/domain/model/collection_id.dart';

class CollectionMapper {
  static CollectionEntity transformToEntity(Collection collection) {
    CollectionEntity entity = CollectionEntity();
    entity.name = collection.name;
    entity.icon = collection.icon;
    entity.placeMarkers =
        collection.placeMarkers.map<PlaceMarkerEntity>((p) => PlaceMarkerMapper.transformToEntity(p)).toList();
    return entity;
  }

  static Collection transformToModel(CollectionEntity collectionEntity) {
    Collection collection = Collection(
        id: CollectionId(value: collectionEntity.id),
        name: collectionEntity.name!,
        icon: collectionEntity.icon!,
        placeMarkers: collectionEntity.placeMarkers!.map((p) => PlaceMarkerMapper.transformToModel(p)).toList());
    return collection;
  }
}
