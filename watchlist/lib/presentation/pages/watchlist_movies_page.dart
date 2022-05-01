import 'package:common/common/constants.dart';
import 'package:common/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:tv_series/presentation/bloc/tv/tv_series_watchlist/tv_series_watchlist_bloc.dart';
import 'package:tv_series/presentation/widgets/tv_series_card_list.dart';
import 'package:watchlist/presentation/movie/movie_watchlist/movie_watchlist_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/watchlist-movie';

  const WatchlistMoviesPage({Key? key}) : super(key: key);

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

  @override
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
        title: const Text('Watchlist'),
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
                const SizedBox(height: 16),
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
        return const Center(
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
        return const Center(
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
