import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:turma_02/data/repositories/product/product_repository_remote.dart';
import 'package:turma_02/data/services/api_client.dart';
import 'package:turma_02/ui/products/viewmodels/products_viewmodel.dart';
import 'package:turma_02/ui/products/widgets/products_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ProductScreen(
        viewModel: ProductsViewModel(ProductRepositoryRemote(ApiClient("http://192.168.1.106:3000", Dio()))),
      ),
    );
  }
}
