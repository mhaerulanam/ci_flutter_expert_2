import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/constants.dart';
import '../bloc/tv/tv_series_watchlist/tv_series_watchlist_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieWatchlistBloc>().add(GetListEvent());
    });
    Future.microtask(() {
      context.read<TvSeriesWatchlistBloc>().add(GetListEventTv());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Future.microtask(() {
      context.read<MovieWatchlistBloc>().add(GetListEvent());
    });
    Future.microtask(() {
      context.read<TvSeriesWatchlistBloc>().add(GetListEventTv());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Watchlist Movie',
                  style: kHeading6,
                ),
                _watchListMovie(),
                SizedBox(height: 16),
                Text(
                  'Watchlist Tv Series',
                  style: kHeading6,
                ),
                _watchListTvSeries(),
              ],
            ),
          )),
    );
  }

  Widget _watchListMovie() {
    return BlocBuilder<MovieWatchlistBloc, MovieWatchlistState>(
        builder: (context, state) {
      if (state is MovieWatchlistLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is MovieWatchlistHasData) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final movie = state.result[index];
            return MovieCard(movie);
          },
          shrinkWrap: true,
          itemCount: state.result.length,
        );
      } else if (state is MovieWatchlistError) {
        return Center(
          key: const Key('error_message'),
          child: Text(state.message),
        );
      } else {
        return const Center(
          key: Key('error_message'),
          child: Text("Error"),
        );
      }
    });
  }

  Widget _watchListTvSeries() {
    return BlocBuilder<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
        builder: (context, state) {
      if (state is TvSeriesWatchlistLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is TvSeriesWatchlistHasData) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final tv = state.result[index];
            return Column(
              children: [
                TvSeriesCard(tv),
              ],
            );
          },
          shrinkWrap: true,
          itemCount: state.result.length,
        );
      } else if (state is TvSeriesWatchlistError) {
        return Center(
          key: const Key('error_message'),
          child: Text(state.message),
        );
      } else {
        return const Center(
          key: Key('error_message'),
          child: Text("Error"),
        );
      }
    });
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
