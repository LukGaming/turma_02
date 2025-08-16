import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turma_02/config/dependencies.dart';
import 'package:turma_02/my_app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: providersRemote,
      child: const MyApp(),
    ),
  );
}
