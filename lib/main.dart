import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lockin_native_2/core/theme.dart';
import 'package:lockin_native_2/router.dart';

void main(){
  runApp(
    const ProviderScope(
      child: LockInApp()
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
      routerConfig: router
    );
  }
}