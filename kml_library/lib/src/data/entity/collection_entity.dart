import 'package:isar/isar.dart';

part 'collection_entity.g.dart';

@collection
class CollectionEntity {
  Id id = Isar.autoIncrement;

  String? name;

  String? icon;

  List<PlaceMarkerEntity>? placeMarkers;
}

@embedded
class PlaceMarkerEntity {
  String? name;
  String? description;
  String? icon;
  int? color;
  double? xCoordinate;
  double? yCoordinate;
}
