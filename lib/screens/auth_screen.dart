

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lockin_native_2/providers/auth_provider.dart';

class AuthScreen extends ConsumerStatefulWidget{
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() =>_AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Card(
        child: FloatingActionButton(
          onPressed: () async => {await ref.read(authProvider.notifier).signIn("", "")},
          child: Text("SignIn"),
        ),
      )
    );
  }
}