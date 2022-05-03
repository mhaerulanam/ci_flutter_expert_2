import 'package:common/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:tv_series/presentation/bloc/tv/search/tv_search_bloc.dart';
import 'package:tv_series/presentation/widgets/tv_series_card_list.dart';
import '../bloc/movie/search/search_bloc.dart';

class SearchPage extends StatelessWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/search';
  final bool isMovie;

  const SearchPage({Key? key, required this.isMovie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                if (isMovie) {
                  context.read<SearchBloc>().add(OnQueryChanged(query));
                } else {
                  context.read<TvSearchBloc>().add(TvOnQueryChange(query));
                }
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            if (isMovie) _blocMovie(),
            if (!isMovie) _blocTvSeries(),
          ],
        ),
      ),
    );
  }

  Widget _blocMovie() {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      if (state is SearchLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is SearchHasData) {
        final result = state.result;
        return Expanded(
            child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            final movie = result[index];
            return MovieCard(movie);
          },
          itemCount: result.length,
        ));
      } else if (state is SearchError) {
        return Expanded(
          child: Center(
            child: Text(state.message),
          ),
        );
      } else {
        return Expanded(
          child: Container(),
        );
      }
    });
  }

  Widget _blocTvSeries() {
    return BlocBuilder<TvSearchBloc, TvSearchState>(builder: (context, state) {
      if (state is TvSearchLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is TvSearchHasData) {
        final result = state.result;
        return Expanded(
            child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            final tvSeries = result[index];
            return TvSeriesCard(tvSeries);
          },
          itemCount: result.length,
        ));
      } else if (state is TvSearchError) {
        return Expanded(
          child: Center(
            child: Text(state.message),
          ),
        );
      } else {
        return Expanded(
          child: Container(),
        );
      }
    });
  }
}
