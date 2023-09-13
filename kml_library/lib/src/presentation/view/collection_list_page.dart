import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kml_library/src/domain/model/library.dart';
import 'package:kml_library/src/presentation/viewmodel/collection_list_viewmodel.dart';

class CollectionListPage extends StatelessWidget {
  final _collectionListProvider = collectionListViewModelStateNotifierProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.collectionListTitle),
        centerTitle: true,
        actions: const [IconButton(onPressed: null, icon: Icon(Icons.settings_outlined))],
      ),
      body: Column(
        children: [
          Consumer(builder: (context, ref, _) {
            return ref.watch(_collectionListProvider).maybeWhen(
                  success: (content) => _buildCollectionListContainerWidget(ref, content),
                  error: (_) => _buildErrorWidget(),
                  orElse: () => const Expanded(child: Center(child: CircularProgressIndicator())),
                );
          }),
        ],
      ),
    );
  }

  Widget _buildErrorWidget() {
    return const Center(child: Text('An error has occurred!'));
  }

  Widget _buildCollectionListContainerWidget(WidgetRef ref, final Library library) {
    return Expanded(child: _buildCollectionListWidget(ref, library));
  }

  Widget _buildCollectionListWidget(final WidgetRef ref, final Library library) {
    if (library.length == 0) {
      return const Center(child: Text('No Collection Available'));
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: library.length,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (final BuildContext context, final int index) {
          return ListTile(
            leading: Text(
              library[index].icon,
              style: TextStyle(fontSize: 25),
            ),
            title: Text(
              library[index].name,
            ),
            subtitle: Text("${library[index].placeMarkers.length.toString()} Items"),
          );
        },
      );
    }
  }
}
