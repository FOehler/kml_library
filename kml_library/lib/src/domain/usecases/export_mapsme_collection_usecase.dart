import 'dart:io';

import 'package:flutter_share/flutter_share.dart';
import 'package:kml_library/src/domain/logic/generators/mapsme_file_creator.dart';
import 'package:kml_library/src/domain/model/collection.dart';
import 'package:kml_library/src/domain/usecases/i_export_mapsme_collection_usecase.dart';
import 'package:path_provider/path_provider.dart';

class ExportMapsMeCollectionUseCase implements IExportMapsMeCollectionUseCase {
  @override
  Future execute(Collection collection) async {
    MapsMeFileCreator fileCreator = MapsMeFileCreator();
    String fileContent = fileCreator.buildFile(collection);
    Directory dir = (await getExternalStorageDirectory())!;
    String filePath = "${dir.path}/${collection.name}.kml";
    File file = File(filePath);
    file.writeAsString(fileContent);
    await FlutterShare.shareFile(
      title: 'KML File Share',
      filePath: file.path,
    );
  }
}
