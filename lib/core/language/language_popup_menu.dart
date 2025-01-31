import 'package:app_management_system/core/language/language.dart';
import 'package:app_management_system/core/language/language_repository.dart';
import 'package:app_management_system/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LanguagePopupMenu extends HookConsumerWidget {
  const LanguagePopupMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(languageProvider);

    return PopupMenuButton(
      onSelected: (value) {
        print('isi value update ${value.toString()}');
        ref.read(languageRepositoryProvider).setLanguage(value);
      },
      itemBuilder: (context) => [
        for (var value in Language.values)
          PopupMenuItem(
              value: value,
              child: Row(
                children: [Text(value.flag), AppStyle.gapW8, Text(value.name)],
              ))
      ],
      child: Text('${language.name} ${language.flag}'),
    );
  }
}
