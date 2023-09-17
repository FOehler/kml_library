import 'package:kml_library/src/domain/model/collection.dart';

abstract class IParser {
  Future<Collection> parse();
}
