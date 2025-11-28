import 'package:base_project/features/product_detail/presentation/bloc/product_detail_bloc.dart';
import 'package:base_project/features/product_detail/presentation/bloc/product_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailBody extends StatelessWidget {
  const ProductDetailBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        if (state is ProductDetailLoading || state is ProductDetailInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProductDetailFailure) {
          return Center(
            child: Text('Failed to load product: ${state.message}'),
          );
        }

        if (state is ProductDetailSuccess) {
          final product = state.product;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Gallery
                SizedBox(
                  height: 250,
                  child: PageView.builder(
                    itemCount: product.images.length,
                    itemBuilder: (context, index) {
                      return Image.network(product.images[index], fit: BoxFit.contain);
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Title and Brand
                Text(product.title, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('by ${product.brand}', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600])),
                const SizedBox(height: 16),

                // Price and Discount
                Row(
                  children: [
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    const SizedBox(width: 12),
                    Chip(
                      label: Text('${product.discountPercentage}% OFF'),
                      backgroundColor: Colors.red[100],
                      labelStyle: TextStyle(color: Colors.red[800], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Rating and Stock
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 4),
                    Text('${product.rating} / 5.0', style: Theme.of(context).textTheme.titleMedium),
                    const Spacer(),
                    Text('${product.stock} in stock', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: product.stock > 0 ? Colors.green : Colors.red)),
                  ],
                ),
                const Divider(height: 32),

                // Description
                Text('Description', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(product.description, style: Theme.of(context).textTheme.bodyLarge),
                const Divider(height: 32),

                // Reviews
                Text('Reviews (${product.reviews.length})', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: product.reviews.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final review = product.reviews[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(review.reviewerName, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(review.comment),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [Text(review.rating.toString()), const Icon(Icons.star, size: 16, color: Colors.amber)],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
