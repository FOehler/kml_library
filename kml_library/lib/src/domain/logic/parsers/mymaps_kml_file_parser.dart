import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kml_library/src/domain/logic/helpers/hex_color.dart';
import 'package:kml_library/src/domain/logic/parsers/i_parser.dart';
import 'package:kml_library/src/domain/model/collection.dart';
import 'package:kml_library/src/domain/model/collection_id.dart';
import 'package:kml_library/src/domain/model/place_marker.dart';
import 'package:kml_library/src/domain/model/place_marker_id.dart';
import 'package:xml/xml.dart';

class MyMapsKmlFileParser implements IParser {
  RegExp exp = RegExp(r'(icon-\w*-\w*)');
  final File file;

  MyMapsKmlFileParser(this.file) {}

  @override
  Future<Collection> parse() async {
    final content = await file.readAsString();
    XmlDocument document = XmlDocument.parse(content);
    Map<String, String> styleLookup = {};
    document.findAllElements("Style").forEach((element) {
      var value = element.attributes.firstWhere((a) => a.localName == "id").value;
      RegExpMatch? match = exp.firstMatch(value);
      styleLookup[match![0]!] = element.findElements("IconStyle").first.findElements("color").first.innerText;
    });
    List<PlaceMarker> placeMarkers = [];
    document.findAllElements("Folder").forEach((folderElement) {
      folderElement.findAllElements("Placemark").forEach((element) {
        var name = element.childElements.firstWhere((e) => e.localName == "name").innerXml;
        var description = element.childElements.where((e) => e.localName == "description").isEmpty
            ? ""
            : element.childElements.firstWhere((e) => e.localName == "description").innerXml;
        var coordinates = element.childElements
            .firstWhere((e) => e.localName == "Point")
            .childElements
            .firstWhere((e) => e.localName == "coordinates")
            .innerText
            .trim();
        var xCoordinate = double.parse(coordinates.split(",")[0]);
        var yCoordinate = double.parse(coordinates.split(",")[1]);
        var styleUrl = element.childElements.firstWhere((e) => e.localName == "styleUrl").innerText;
        var styleUrlForLookup = exp.firstMatch(styleUrl)![0]!; // substring to remove #
        placeMarkers.add(PlaceMarker(
            id: const PlaceMarkerId(value: 0),
            name: name,
            description: description,
            icon: "",
            color: styleLookup[styleUrlForLookup] != null
                ? HexColor(styleLookup[styleUrlForLookup]!).value
                : Colors.red[400]!.value,
            xCoordinate: xCoordinate,
            yCoordinate: yCoordinate));
      });
    });
    var collectionName = document.findAllElements("name").first.innerText;

    return Future.value(
        Collection(id: const CollectionId(value: 0), name: collectionName, icon: "", placeMarkers: placeMarkers));
  }
}
