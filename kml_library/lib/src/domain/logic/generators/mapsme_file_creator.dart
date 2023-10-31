import 'package:kml_library/src/domain/logic/helpers/hex_color.dart';
import 'dart:ui';
import 'dart:core';

import 'package:kml_library/src/domain/model/collection.dart';
import 'package:kml_library/src/domain/model/place_marker.dart';

class MapsMeFileCreator {
  final styleString = "#placemark-{0}";
  final colors = <String, Color>{
    "red": HexColor("#FFE51C24"),
    "pink": HexColor("#FFFF4181"),
    "purple": HexColor("#FF9C28B1"),
    "deeppurple": HexColor("#FF6739BF"),
    "blue": HexColor("#FF006EC7"),
    "lightblue": HexColor("#FF259BF2"),
    "cyan": HexColor("#FF16BECB"),
    "teal": HexColor("#FF00A78D"),
    "green": HexColor("#FF398E3D"),
    "lime": HexColor("#FF94C039"),
    "yellow": HexColor("#FFFFC800"),
    "orange": HexColor("#FFFDAA0E"),
    "deeporange": HexColor("#FFF06431"),
    "brown": HexColor("#FF785245"),
    "gray": HexColor("#FF737373"),
    "bluegray": HexColor("#FF597380")
  };

  String buildFile(Collection collection) {
    String startOfFile = """<?xml version="1.0" encoding="UTF-8"?>
    <kml xmlns="http://www.opengis.net/kml/2.2">
      <Document>
        <name>${collection.name}</name>
        <description/>
        <Folder>
          <name />
    """;
    String endOfFile = """
        </Folder>
      </Document>
    </kml>
    """;

    var buffer = StringBuffer();
    buffer.write(startOfFile);
    for (var element in collection.placeMarkers) {
      buffer.write(getPlaceMarkString(element));
    }
    buffer.write(endOfFile);
    return buffer.toString();
  }

  String getPlaceMarkString(PlaceMarker placeMarker) {
    return """
      <Placemark>
        <name>${placeMarker.name}</name>
        <description>${placeMarker.description}</description>
        <styleUrl>#placemark-${getClosestColor(Color(placeMarker.color))}</styleUrl>
        <Point>
          <coordinates>
            ${placeMarker.xCoordinate},${placeMarker.yCoordinate},0
          </coordinates>
        </Point>
      </Placemark>
    """;
  }

  String getClosestColor(Color color) {
    String closestColor = "red";
    int distance = 1000000000;
    colors.forEach((key, value) {
      if (getDistance(value, color) < distance) {
        distance = getDistance(value, color);
        closestColor = key;
      }
    });
    return closestColor;
  }

  int getDistance(Color a, Color b) {
    return (a.red - b.red).abs() +
        (a.green - b.green).abs() +
        (a.blue - b.blue).abs();
  }
}
