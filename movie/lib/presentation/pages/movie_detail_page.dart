import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:home/presentation/pages/home_movie_page.dart';
import 'package:movie/domain/entities/genre.dart';
import 'package:movie/presentation/bloc/movie/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:tv_series/presentation/bloc/tv/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv/tv_series_episode/tv_series_episode_bloc.dart';
import 'package:tv_series/presentation/bloc/tv/tv_series_recommendation/tv_series_recommendation_bloc.dart';
import 'package:tv_series/presentation/bloc/tv/tv_series_watchlist/tv_series_watchlist_bloc.dart';
import 'package:watchlist/presentation/movie/movie_watchlist/movie_watchlist_bloc.dart';

class MovieDetailArgs {
  final int id;
  final bool isMovie;

  MovieDetailArgs({
    required this.id,
    required this.isMovie,
  });
}

class MovieDetailPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/detail';

  final MovieDetailArgs args;

  const MovieDetailPage({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (widget.args.isMovie) {
        context
            .read<MovieDetailBloc>()
            .add(GetMovieDetailEvent(widget.args.id));
        context
            .read<MovieRecommendationBloc>()
            .add(GetMovieRecommendationEvent(widget.args.id));
        context
            .read<MovieWatchlistBloc>()
            .add(GetStatusMovieEvent(widget.args.id));
      } else {
        context
            .read<TvSeriesDetailBloc>()
            .add(GetTvDetailEvent(widget.args.id));
        context
            .read<TvSeriesRecommendationBloc>()
            .add(GetTvSeriesRecommendationEvent(widget.args.id));
        context
            .read<TvSeriesWatchlistBloc>()
            .add(GetStatusTvSeriesEvent(widget.args.id));
        context
            .read<TvSeriesEpisodeBloc>()
            .add(TvSeriesEpisodeGetEvent(widget.args.id, 1));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.args.isMovie ? _movieBlocBuilder() : _tvConsumer(),
    );
  }

  Widget _movieBlocBuilder() {
    return BlocListener<MovieWatchlistBloc, MovieWatchlistState>(
      listener: (_, state) {
        if (state is MovieWatchlistSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));

          context
              .read<MovieWatchlistBloc>()
              .add(GetStatusMovieEvent(widget.args.id));
        }
      },
      child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
        if (state is MovieDetailLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MovieDetailHasData) {
          final movie = state.movieDetail;
          bool isAddedWatchlist = (context.watch<MovieWatchlistBloc>().state
                  is MovieWatchlistStatusHasData)
              ? (context.read<MovieWatchlistBloc>().state
                      as MovieWatchlistStatusHasData)
                  .result
              : false;
          return SafeArea(
            child: DetailContent(
              isAddedWatchlist: isAddedWatchlist,
              voteAverage: movie.voteAverage!,
              title: movie.title.toString(),
              runtime: movie.runtime!,
              overview: movie.overview!,
              imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
              genres: movie.genres!,
              onWatchListClick: () async {
                if (!isAddedWatchlist) {
                  context
                      .read<MovieWatchlistBloc>()
                      .add(AddItemMovieEvent(movie));
                } else {
                  context
                      .read<MovieWatchlistBloc>()
                      .add(RemoveItemMovieEvent(movie));
                }
              },
              lwSeason: [Container()],
              lwEpisode: [Container()],
              lwRecommendations: [
                const SizedBox(height: 16),
                Text(
                  'Recommendations',
                  style: kHeading6,
                ),
                BlocBuilder<MovieRecommendationBloc, MovieRecommendationState>(
                    builder: (context, state) {
                  if (state is MovieRecommendationLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MovieRecommendationError) {
                    return Text(state.message);
                  } else if (state is MovieRecommendationHasData) {
                    final recommendations = state.movie;
                    if (recommendations.isEmpty) {
                      return const Text("No recommendations");
                    }
                    return SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final movie = recommendations[index];
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: HomeItem(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                              onClick: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  MovieDetailPage.ROUTE_NAME,
                                  arguments: MovieDetailArgs(
                                      id: movie.id!, isMovie: true),
                                );
                              },
                            ),
                          );
                        },
                        itemCount: recommendations.length,
                      ),
                    );
                  } else {
                    return const Text("No recommendations");
                  }
                }),
              ],
            ),
          );
        } else if (state is MovieDetailError) {
          return Text(state.message);
        } else {
          return const Text("Error");
        }
      }),
    );
  }

  Widget _tvConsumer() {
    return BlocListener<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
      listener: (_, state) {
        if (state is TvSeriesWatchlistSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));

          context
              .read<TvSeriesWatchlistBloc>()
              .add(GetStatusTvSeriesEvent(widget.args.id));
        }
      },
      child: BlocBuilder<TvSeriesDetailBloc, TvSeriesDetailState>(
          builder: (context, state) {
        if (state is TvDetailLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TvDetailHasData) {
          final tv = state.tvDetail;
          final seasons = tv.seasons;
          bool isAddedWatchlist = (context.watch<TvSeriesWatchlistBloc>().state
                  is TvSeriesWatchlistStatusHasData)
              ? (context.read<TvSeriesWatchlistBloc>().state
                      as TvSeriesWatchlistStatusHasData)
                  .result
              : false;

          return SafeArea(
            child: DetailContent(
              isAddedWatchlist: isAddedWatchlist,
              voteAverage: tv.voteAverage!,
              title: tv.name.toString(),
              runtime: tv.episodeRunTime?.first ?? 0,
              overview: tv.overview.toString(),
              imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
              genres: tv.genres!,
              onWatchListClick: () async {
                if (!isAddedWatchlist) {
                  context
                      .read<TvSeriesWatchlistBloc>()
                      .add(AddItemTvSeriesEvent(tv));
                } else {
                  context
                      .read<TvSeriesWatchlistBloc>()
                      .add(RemoveItemTvSeriesEvent(tv));
                }
              },
              lwEpisode: [
                BlocBuilder<TvSeriesEpisodeBloc, TvSeriesEpisodeState>(
                  builder: (context, state) {
                    if (state is TvEpisodeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is TvEpisodeHasData) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 16),
                          Text(
                            'Episode',
                            style: kHeading6,
                          ),
                          SizedBox(
                            height: 90,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: state.result.length,
                              itemBuilder: (context, index) {
                                final item = state.result[index];
                                final episode = item.name;
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        constraints: const BoxConstraints(
                                            maxWidth: 160, minWidth: 160),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Episode ${index + 1}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              "\"$episode\"",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 16),
                          Text(
                            'Episode',
                            style: kHeading6,
                          ),
                          const Text("No episode"),
                        ],
                      );
                    }
                  },
                ),
              ],
              lwSeason: seasons?.isEmpty ?? true
                  ? [Container()]
                  : [
                      const SizedBox(height: 16),
                      Text(
                        'Seasons',
                        style: kHeading6,
                      ),
                      SizedBox(
                        height: 90,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: seasons!.length,
                          itemBuilder: (context, index) {
                            final item = seasons[index];
                            String overview = (item.overview) != null
                                ? item.overview.toString()
                                : "-";
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Card(
                                child: InkWell(
                                  onTap: () async {
                                    context.read<TvSeriesEpisodeBloc>().add(
                                        TvSeriesEpisodeGetEvent(
                                            widget.args.id, index));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      constraints: const BoxConstraints(
                                          maxWidth: 160, minWidth: 160),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Season ${index + 1}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            overview,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
              lwRecommendations: [
                const SizedBox(height: 16),
                Text(
                  'Recommendations',
                  style: kHeading6,
                ),
                BlocBuilder<TvSeriesRecommendationBloc,
                    TvSeriesRecommendationState>(builder: (context, state) {
                  if (state is TvSeriesRecommendationLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvSeriesRecommendationError) {
                    return Text(state.message);
                  } else if (state is TvSeriesRecommendationHasData) {
                    final recommendations = state.tvSeries;
                    if (recommendations.isEmpty) {
                      return const Text("No recommendations");
                    }
                    return SizedBox(
                      height: 150,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: recommendations.length,
                        itemBuilder: (context, index) {
                          final tv = recommendations[index];
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: HomeItem(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                              onClick: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  MovieDetailPage.ROUTE_NAME,
                                  arguments: MovieDetailArgs(
                                      id: tv.id!, isMovie: false),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Text("No recommendations");
                  }
                }),
              ],
            ),
          );
        } else if (state is TvDetailError) {
          return Text(state.message);
        } else {
          return const Text("Error");
        }
      }),
    );
  }
}

class DetailContent extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onWatchListClick;
  final List<Genre>? genres;
  final int runtime;
  final double voteAverage;
  final String overview;
  final List<Widget> lwRecommendations;
  final List<Widget> lwSeason;
  final List<Widget> lwEpisode;
  final bool isAddedWatchlist;

  const DetailContent({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.onWatchListClick,
    required this.genres,
    required this.runtime,
    required this.voteAverage,
    required this.overview,
    required this.lwRecommendations,
    required this.isAddedWatchlist,
    required this.lwSeason,
    required this.lwEpisode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: onWatchListClick,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(genres!),
                            ),
                            Text(
                              _showDuration(runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('$voteAverage')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              overview,
                            ),
                            ...lwSeason,
                            ...lwEpisode,
                            ...lwRecommendations,
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
