import 'package:base_project/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarBody extends StatelessWidget {
  const CalendarBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Use BlocBuilder as the single source of truth for building the UI.
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        // While loading, show a central progress indicator.
        if (state is CalendarLoading || state is CalendarInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // If there's an error, display it clearly.
        if (state is CalendarFailure) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Failed to load products: ${state.message}',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        // On success, display the list of products.
        if (state is CalendarSuccess) {
          final products = state.productListEntity.products;

          if (products.isEmpty) {
            return const Center(child: Text('No products found.'));
          }

          return ListView.builder(
            itemCount: products.length,
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                elevation: 3,
                margin:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Image.network(
                        product.thumbnail,
                        fit: BoxFit.cover,
                        // Add loading and error builders for the image itself
                        loadingBuilder: (context, child, progress) =>
                        progress == null
                            ? child
                            : const Center(
                            child: CircularProgressIndicator()),
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image,
                            size: 40, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Product Details
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            // Category Chip
                            Chip(
                              label: Text(product.category.toUpperCase()),
                              backgroundColor: Colors.blue.withOpacity(0.1),
                              labelStyle: const TextStyle(
                                color: Colors.blue,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            const SizedBox(height: 8),
                            // Price
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }

        // Fallback for any other unhandled state.
        return const SizedBox.shrink();
      },
    );
  }
}
