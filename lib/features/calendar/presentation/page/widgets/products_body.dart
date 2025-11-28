import 'package:base_project/features/calendar/presentation/bloc/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsBody extends StatefulWidget {
  const ProductsBody({super.key});

  @override
  State<ProductsBody> createState() => _ProductsBodyState();
}

class _ProductsBodyState extends State<ProductsBody> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<ProductsBloc>().add(ProductsRefreshed());
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ProductsBloc>().add(ProductsFetched());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    // Fetch data when user is close to the bottom (e.g., 90% of the way).
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductsBloc, ProductsState>(
      listener: (context, state) {},
      child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          switch (state) {
            case ProductsInitial():
              return const Center(child: CircularProgressIndicator());

            case ProductsFailure(message: final message):
              return Center(
                child: Text(
                  'Failed to load products: $message',
                  style: const TextStyle(color: Colors.red),
                ),
              );

            case ProductsSuccess():
              if (state.products.isEmpty) {
                return const Center(child: Text('No products found.'));
              }
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ProductsBloc>().add(ProductsRefreshed());
                },
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  itemCount: state.hasReachedMax
                      ? state.products.length
                      : state.products.length + 1,
                  itemBuilder: (context, index) {
                    if (index >= state.products.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final product = state.products[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: Image.network(
                              product.thumbnail,
                              fit: BoxFit.cover,
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
                                  Chip(
                                    label: Text(product.category.toUpperCase()),
                                    backgroundColor:
                                        Colors.blue.withOpacity(0.1),
                                    labelStyle: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                  const SizedBox(height: 8),
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
                ),
              );

            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
