import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kml_library/src/domain/model/collection.dart';
import 'package:kml_library/src/domain/model/place_marker.dart';
import 'package:kml_library/src/domain/usecases/export_mapsme_collection_usecase.dart';
import 'package:kml_library/src/presentation/viewmodel/marker_list/collection_settings_viewmodel.dart';

class MarkerListPage extends ConsumerStatefulWidget {
  final Collection _collection;

  MarkerListPage(this._collection);

  @override
  MarkerListPageState createState() => MarkerListPageState();
}

class MarkerListPageState extends ConsumerState<MarkerListPage> {
  late final CollectionSettingsViewModel _viewModel;
  int currentPageIndex = 0;
  final collectionNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(collectionSettingsViewModelProvider);
    collectionNameController.text = widget._collection.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._collection.name),
        // TODO: implement search
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.search),
        //     onPressed: () => null,
        //   )
        // ],
      ),
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.explore_outlined),
              selectedIcon: Icon(Icons.explore),
              label: 'Markers',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: 'Settings',
            ),
            NavigationDestination(
              icon: Icon(Icons.download_outlined),
              selectedIcon: Icon(Icons.download),
              label: 'Export',
            ),
          ]),
      body: <Widget>[
        SafeArea(
          child: _buildMarkerListContainerWidget(widget._collection),
        ),
        SafeArea(
          child: _buildSettingsPage(widget._collection),
        ),
        SafeArea(
          child: _buildExportPage(widget._collection),
        ),
      ][currentPageIndex],
    );
  }

  Widget _buildMarkerListContainerWidget(Collection collection) {
    return Column(
      children: [
        Expanded(child: _buildMarkerListWidget(collection)),
      ],
    );
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
          return _buildPlaceMarkerItemCard(
              context, collection.placeMarkers[index]);
        },
      );
    }
  }

  Widget _buildPlaceMarkerItemCard(
      BuildContext context, PlaceMarker placeMarker) {
    return ListTile(
        leading: Icon(
          Icons.place_outlined,
          color: Color(placeMarker.color),
        ),
        title: Text(
          placeMarker.name,
        ),
        subtitle:
            Text("${placeMarker.xCoordinate}, ${placeMarker.yCoordinate}"));
  }

  Widget _buildSettingsPage(Collection collection) {
    final formKey = GlobalKey<FormState>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: TextFormField(
                controller: collectionNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Collection Name',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _viewModel.deleteCollection(collection.id);
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.primaries[0], elevation: 0),
                  child: Text(AppLocalizations.of(context)!
                      .collectionSettingPageDeleteButton),
                ),
                const SizedBox(
                  width: 10,
                ),
                FilledButton(
                    onPressed: () {
                      _viewModel.renameCollection(
                          collection.id, collectionNameController.text);
                      setState((() {
                        widget._collection.name = collectionNameController.text;
                        currentPageIndex = 0;
                      }));
                    },
                    child: Text(AppLocalizations.of(context)!
                        .collectionSettingPageSaveButton)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExportPage(Collection collection) {
    return Column(children: [
      Card(
          margin: const EdgeInsets.all(8),
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.exportMapsMeHeader,
                      style: const TextStyle(fontSize: 24)),
                  Text(AppLocalizations.of(context)!.exportMapsMeInfoText),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildExportButton(context, ref, collection),
                    ],
                  )
                ],
              )))
    ]);
  }

  _buildExportButton(
      BuildContext context, WidgetRef ref, Collection collection) {
    return FilledButton(
      child: Text(AppLocalizations.of(context)!.exportPageImportButton),
      onPressed: () {
        ExportMapsMeCollectionUseCase useCase = ExportMapsMeCollectionUseCase();
        useCase.execute(collection);
      },
    );
  }
}
