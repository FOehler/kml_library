import 'package:kml_library/src/domain/model/collection.dart';

abstract class IExportMapsMeCollectionUseCase {
  Future execute(Collection collection);
}
