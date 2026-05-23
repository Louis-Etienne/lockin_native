

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerStatefulWidget{
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() =>_AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen>{
  bool _isLoading = false;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Text("Coming soon")
    );
  }
}