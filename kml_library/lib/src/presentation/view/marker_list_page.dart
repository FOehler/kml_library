import 'package:flutter/material.dart';
import 'package:kml_library/src/domain/model/collection.dart';
import 'package:kml_library/src/domain/model/place_marker.dart';

class MarkerListPage extends StatelessWidget {
  final Collection _collection;

  const MarkerListPage(this._collection);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_collection.name),
        centerTitle: true,
        actions: const [IconButton(onPressed: null, icon: Icon(Icons.settings_outlined))],
      ),
      body: Column(
        children: [_buildMarkerListContainerWidget(_collection)],
      ),
    );
  }

  Widget _buildMarkerListContainerWidget(Collection collection) {
    return Expanded(child: _buildMarkerListWidget(collection));
  }

  _buildMarkerListWidget(Collection collection) {
    if (collection.placeMarkers.isEmpty) {
      return const Center(child: Text('No Collection Available'));
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: collection.placeMarkers.length,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (final BuildContext context, final int index) {
          return _buildPlaceMarkerItemCard(context, collection.placeMarkers[index]);
        },
      );
    }
  }

  Widget _buildPlaceMarkerItemCard(BuildContext context, PlaceMarker placeMarker) {
    return ListTile(
        leading: const Icon(
          Icons.place_outlined,
        ),
        title: Text(
          placeMarker.name,
        ),
        subtitle: Text("${placeMarker.xCoordinate}, ${placeMarker.yCoordinate}"));
  }
}
