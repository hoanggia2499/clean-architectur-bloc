import 'package:base_project/core/widget/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_project/core/di/injection.dart';
import 'package:base_project/features/product_detail/presentation/bloc/product_detail_bloc.dart';
import 'package:base_project/features/product_detail/presentation/bloc/product_detail_event.dart';
import 'widgets/product_detail_body.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductDetailBloc>()..add(GetProductDetail(productId)),
      child: const AppScaffold(
        bodyPortrait: ProductDetailBody(),
        // You can create a specific landscape layout if needed
        bodyLandScape: ProductDetailBody(),
      ),
    );
  }
}
