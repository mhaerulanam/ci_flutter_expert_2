import 'package:common/common/state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:tv_series/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:tv_series/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:tv_series/domain/usecases/save_watchlist_tv_series.dart';

import '../../domain/entities/episode.dart';
import '../../domain/usecases/get_tv_episode.dart';
import '../../domain/usecases/get_tv_series_detail.dart';
import '../../domain/usecases/get_tv_series_recommendations.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;
  final GetWatchListStatusTvSeries getWatchListStatusTvSeries;
  final SaveWatchlistTvSeries saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries removeWatchlistTvSeries;
  final GetTvEpisode getTvEpisode;

  TvSeriesDetailNotifier({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendations,
    required this.getWatchListStatusTvSeries,
    required this.saveWatchlistTvSeries,
    required this.removeWatchlistTvSeries,
    required this.getTvEpisode,
  });

  late DetailTvSeries _tvSeries;
  DetailTvSeries get tvSeries => _tvSeries;

  RequestState _tvSeriesState = RequestState.Empty;
  RequestState get tvSeriesState => _tvSeriesState;

  List<TvSeries> _tvSeriesRecommendations = [];
  List<TvSeries> get tvSeriesRecommendations => _tvSeriesRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  List<Episode> _tvEpisode = [];
  List<Episode> get tvEpisode => _tvEpisode;

  RequestState _episodeState = RequestState.Empty;
  RequestState get episodeState => _episodeState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlistTvSeries = false;
  bool get isAddedToWatchlistTvSeries => _isAddedtoWatchlistTvSeries;

  Future<void> fetchTvSeriesDetail(int id) async {
    _tvSeriesState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvSeriesDetail.execute(id);
    final recommendationResult = await getTvSeriesRecommendations.execute(id);
    final episodeResult = await getTvEpisode.execute(id, 1);

    detailResult.fold(
      (failure) {
        _tvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tv) async {
        _recommendationState = RequestState.Loading;
        _tvSeries = tv;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (tvs) {
            _recommendationState = RequestState.Loaded;
            _tvSeriesRecommendations = tvs;

            episodeResult.fold(
              (l) {
                _episodeState = RequestState.Error;
                _message = l.message;
                notifyListeners();
              },
              (r) {
                _episodeState = RequestState.Loaded;
                _tvEpisode = r;
                notifyListeners();
              },
            );
          },
        );
        _tvSeriesState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future fetchTvEpisode(int idTv, int idSeason) async {
    _episodeState = RequestState.Loading;
    notifyListeners();
    final episodeResult = await getTvEpisode.execute(idTv, idSeason);

    episodeResult.fold(
      (l) {
        _episodeState = RequestState.Error;
        _message = l.message;
        notifyListeners();
      },
      (r) {
        _episodeState = RequestState.Loaded;
        _tvEpisode = r;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlistTvSeries(DetailTvSeries tvSeries) async {
    final result = await saveWatchlistTvSeries.execute(tvSeries);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatusTVSeries(tvSeries.id!);
  }

  Future<void> removeFromWatchlistTvSeries(DetailTvSeries tvSeries) async {
    final result = await removeWatchlistTvSeries.execute(tvSeries);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatusTVSeries(tvSeries.id!);
  }

  Future<void> loadWatchlistStatusTVSeries(int id) async {
    final result = await getWatchListStatusTvSeries.execute(id);
    _isAddedtoWatchlistTvSeries = result;
    notifyListeners();
  }
}
