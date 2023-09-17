import 'package:flutter_archive/flutter_archive.dart';
import 'package:kml_library/src/domain/logic/parsers/i_parser.dart';
import 'package:kml_library/src/domain/model/collection.dart';
import 'package:kml_library/src/domain/model/collection_id.dart';
import 'package:kml_library/src/domain/model/place_marker_id.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xml/xml.dart';
import 'dart:core';
import 'package:flutter/material.dart';
import 'dart:io';

import '../../model/place_marker.dart';

class MyMapsKmzFileParser implements IParser {
  RegExp exp = RegExp(r'(icon-\w*-\w*)');
  final File zipFile;

  MyMapsKmzFileParser(this.zipFile) {}

  Future<Color> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor!.color;
  }

  @override
  Future<Collection> parse() async {
    final destinationDir = await getTemporaryDirectory();
    try {
      await ZipFile.extractToDirectory(zipFile: zipFile, destinationDir: destinationDir);
    } catch (e) {
      print(e);
    }

    final List<FileSystemEntity> entities = await Directory("${destinationDir.path}/images").list().toList();

    Map<String, Color> iconColorLookup = {};
    for (var element in entities) {
      Color color = await getImagePalette(Image.file(File(element.path)).image);
      iconColorLookup["images/${basename(element.path)}"] = color;
    }

    File kmlFile = File("${destinationDir.path}/doc.kml");
    final kmlFileContent = await kmlFile.readAsString();
    XmlDocument document = XmlDocument.parse(kmlFileContent);
    Map<String, Color> styleLookup = {};
    document.findAllElements("Style").forEach((element) {
      var value = element.attributes.firstWhere((a) => a.localName == "id").value;
      RegExpMatch? match = exp.firstMatch(value);
      styleLookup[match![0]!] = iconColorLookup[element
              .findElements("IconStyle")
              .first
              .findElements("Icon")
              .first
              .findElements("href")
              .first
              .innerText] ??
          Colors.red;
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
            color:
                styleLookup[styleUrlForLookup] != null ? styleLookup[styleUrlForLookup]!.value : Colors.red[400]!.value,
            xCoordinate: xCoordinate,
            yCoordinate: yCoordinate));
      });
    });

    var collectionName = document.findAllElements("name").first.innerText;
    return Collection(id: const CollectionId(value: 0), name: collectionName, icon: "", placeMarkers: placeMarkers);
  }
}
