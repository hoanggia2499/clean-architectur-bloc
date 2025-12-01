import 'package:base_project/features/search/domain/entities/search_term_entity.dart';
import 'package:base_project/features/search/presentation/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    final searchBloc = context.read<SearchBloc>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            autofocus: true,
            onChanged: (query) {
              searchBloc.add(SearchQueryChanged(query));
            },
            decoration: InputDecoration(
              labelText: 'Search Products',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is SearchLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is SearchFailure) {
                return const Center(
                  child: Text(
                    'Could not perform search. Please try again.',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }
              if (state is SearchSuccess) {
                if (state.products.isEmpty) {
                  return const Center(child: Text('No products found.'));
                }
                return ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return ListTile(
                      leading: Image.network(product.thumbnail, width: 50, height: 50, fit: BoxFit.cover),
                      title: Text(product.title),
                      subtitle: Text('\$${product.price}'),
                      onTap: () {
                        // Save the search term before navigating.
                        searchBloc.add(SaveSearchTerm(state.currentQuery));
                        final path = '/dashboard/product/${product.id}';
                        context.go(path);
                      },
                    );
                  },
                );
              }
              if (state is SearchInitial) {
                if (state.historyTerms.isEmpty) {
                  return const Center(
                    child: Text('Type something to start searching.'),
                  );
                }
                return _buildSearchHistory(context, state.historyTerms);
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchHistory(BuildContext context, List<SearchTermEntity> history) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Searches',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: history.map((term) {
              return InkWell(
                onTap: () {
                  // Trigger a search with the tapped history term.
                  context.read<SearchBloc>().add(SearchQueryChanged(term.query));
                },
                child: Chip(
                  label: Text(term.query),
                  backgroundColor: Colors.grey[200],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
