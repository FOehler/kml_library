import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kml_library/src/presentation/viewmodel/import_collection/import_collection_viewmodel.dart';

class ImportCollectionPage extends ConsumerWidget {
  final _importCollectionProvider = importCollectionViewModelProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.importPageTitle),
          centerTitle: true,
        ),
        body: Column(
          children: [_buildImportCard(context, ref)],
        ));
  }

  _buildImportCard(BuildContext context, WidgetRef ref) {
    return Card(
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
                Text(AppLocalizations.of(context)!.importGoogleMyMapsHeader, style: const TextStyle(fontSize: 24)),
                Text(AppLocalizations.of(context)!.importGoogleMyMapsInfoText),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildImportButton(context, ref),
                  ],
                )
              ],
            )));
  }

  _buildImportButton(BuildContext context, WidgetRef ref) {
    return FilledButton(
      child: Text(AppLocalizations.of(context)!.importPageImportButton),
      onPressed: () {
        ref.watch(_importCollectionProvider).importMyMapsCollection();
        Navigator.pop(context);
      },
    );
  }
}
