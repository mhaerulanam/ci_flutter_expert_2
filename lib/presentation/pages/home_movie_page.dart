import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/movie/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_popular/movie_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_popular/tv_series_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/tv_series_top_rated/tv_series_top_rated_bloc.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tv/tv_on_the_air/tv_on_the_air_bloc.dart';
import 'on_the_air_tv_series_page.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, keepPage: true);
    Future.microtask(() {
      context.read<MovieNowPlayingBloc>().add(MovieNowPlayingGetEvent());
      context.read<MoviePopularBloc>().add(MoviePopularGetEvent());
      context.read<MovieTopRatedBloc>().add(MovieTopRatedGetEvent());
      context.read<TvOnTheAirBloc>().add(TvOnTheAirGetEvent());
      context.read<TvSeriesPopularBloc>().add(TvSeriesPopularGetEvent());
      context.read<TvSeriesTopRatedBloc>().add(TvSeriesTopRatedGetEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.live_tv),
              title: Text('Movies', style: kSubtitle),
              onTap: () {
                _pageController.jumpToPage(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: Text('Tv Series', style: kSubtitle),
              onTap: () {
                _pageController.jumpToPage(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME,
                  arguments: _pageController.page == 0);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _movie(),
          _tvSeries(),
        ],
      ),
    );
  }

  Widget _movie() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Now Playing',
              style: kHeading6,
            ),
            BlocBuilder<MovieNowPlayingBloc, MovieNowPlayingState>(
                builder: (context, state) {
              if (state is MovieNowPlayingLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is MovieNowPlayingHasData) {
                return MovieList(state.result);
              } else if (state is MovieNowPlayingError) {
                return Text(state.message);
              } else {
                return const Text('Failed');
              }
            }),
            _buildSubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
            ),
            BlocBuilder<MoviePopularBloc, MoviePopularState>(
                builder: (context, state) {
              if (state is MoviePopularLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is MoviePopularHasData) {
                return MovieList(state.result);
              } else if (state is MoviePopularError) {
                return Text(state.message);
              } else {
                return const Text('Failed');
              }
            }),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
            ),
            BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
                builder: (context, state) {
              if (state is MoviePopularLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is MovieTopRatedHasData) {
                return MovieList(state.result);
              } else if (state is MovieTopRatedError) {
                return Text(state.message);
              } else {
                return const Text('Failed');
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _tvSeries() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubHeading(
              title: 'Tv Series Is Airing',
              onTap: () =>
                  Navigator.pushNamed(context, OnTheAirTvSeriesPage.ROUTE_NAME),
            ),
            BlocBuilder<TvOnTheAirBloc, TvOnTheAirState>(
                builder: (context, state) {
              if (state is TvOnTheAirLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvOnTheAirHasData) {
                return TvSeriesList(state.result);
              } else if (state is TvOnTheAirError) {
                return Text(state.message);
              } else {
                return const Text('Failed');
              }
            }),
            _buildSubHeading(
              title: 'Popular Tv Series',
              onTap: () =>
                  Navigator.pushNamed(context, PopularTvSeriesPage.ROUTE_NAME),
            ),
            BlocBuilder<TvSeriesPopularBloc, TvSeriesPopularState>(
                builder: (context, state) {
              if (state is TvSeriesPopularLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvSeriesPopularHasData) {
                return TvSeriesList(state.result);
              } else if (state is TvSeriesPopularError) {
                return Text(state.message);
              } else {
                return const Text('Failed');
              }
            }),
            _buildSubHeading(
              title: 'Top Rated Tv Series',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedTvSeriesPage.ROUTE_NAME),
            ),
            BlocBuilder<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
                builder: (context, state) {
              if (state is TvSeriesTopRatedLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvSeriesTopRatedHasData) {
                return TvSeriesList(state.result);
              } else if (state is TvSeriesTopRatedError) {
                return Text(state.message);
              } else {
                return const Text('Failed');
              }
            }),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tv;

  TvSeriesList(this.tv);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final tvSeries = tv[index];
            return Container(
              padding: const EdgeInsets.all(8),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    MovieDetailPage.ROUTE_NAME,
                    arguments:
                        MovieDetailArgs(id: tvSeries.id!, isMovie: false),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  child: CachedNetworkImage(
                    imageUrl: '$BASE_IMAGE_URL${tvSeries.posterPath}',
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            );
          },
          itemCount: tv.length,
        ));
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: MovieDetailArgs(id: movie.id!, isMovie: true),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}

class HomeItem extends StatelessWidget {
  const HomeItem({
    Key? key,
    required this.imageUrl,
    required this.onClick,
  }) : super(key: key);

  final String imageUrl;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onClick,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
