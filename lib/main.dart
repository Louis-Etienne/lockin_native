import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lockin_native_2/core/theme.dart';
import 'package:lockin_native_2/router.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: const ProviderScope(
        child: LockInApp()
      ),
    ),
  );
}

class LockInApp extends ConsumerWidget{
  const LockInApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: "LockIn",
      theme: AppTheme.themeData,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: router,
    );
  }
}