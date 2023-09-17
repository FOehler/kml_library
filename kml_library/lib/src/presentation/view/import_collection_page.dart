import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImportCollectionPage extends StatelessWidget {
  const ImportCollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.importPageTitle),
          centerTitle: true,
        ),
        body: Column(
          children: [_buildImportCard(context)],
        ));
  }

  _buildImportCard(BuildContext context) {
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
                  FilledButton(
                    child: Text(AppLocalizations.of(context)!.importPageImportButton),
                    onPressed: () {},
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
