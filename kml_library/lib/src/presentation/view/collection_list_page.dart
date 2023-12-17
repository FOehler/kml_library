import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kml_library/src/domain/model/collection.dart';
import 'package:kml_library/src/domain/model/library.dart';
import 'package:kml_library/src/presentation/view/import_collection_page.dart';
import 'package:kml_library/src/presentation/view/marker_list_page.dart';
import 'package:kml_library/src/presentation/viewmodel/collection_list/library_notifier_provider.dart';

class CollectionListPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      CollectionListPageState();
}

class CollectionListPageState extends ConsumerState<CollectionListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final libraryNotifier = ref.watch(libraryNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.collectionListTitle),
        centerTitle: true,
        actions: const [
          // IconButton(onPressed: null, icon: Icon(Icons.settings_outlined)) // TODO: Implement
        ],
      ),
      body: Column(
        children: [
          libraryNotifier.isSuccess
              ? _buildCollectionListContainerWidget(ref, libraryNotifier.data!)
              : const CircularProgressIndicator()
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildErrorWidget() {
    return const Center(child: Text('An error has occurred!'));
  }

  Widget _buildCollectionListContainerWidget(
      WidgetRef ref, final Library library) {
    return Expanded(child: _buildCollectionListWidget(ref, library));
  }

  Widget _buildCollectionListWidget(
      final WidgetRef ref, final Library library) {
    if (library.length == 0) {
      return const Center(child: Text('No Collection Available'));
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: library.length,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (final BuildContext context, final int index) {
          return _buildCollectionItemCard(context, ref, library[index]);
        },
      );
    }
  }

  Widget _buildCollectionItemCard(
      BuildContext context, WidgetRef ref, Collection collection) {
    return ListTile(
      title: Text(
        collection.name,
      ),
      subtitle: Text("${collection.placeMarkers.length.toString()} Items"),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => MarkerListPage(collection)),
      ),
    );
  }

  _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => ImportCollectionPage())),
      child: const Icon(Icons.add),
    );
  }
}
