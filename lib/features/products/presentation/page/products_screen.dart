import 'package:base_project/features/products/presentation/page/widgets/products_body.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/app_scaffold.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        bodyLandScape: const ProductsBody(),
        bodyPortrait: const ProductsBody());
  }
}
