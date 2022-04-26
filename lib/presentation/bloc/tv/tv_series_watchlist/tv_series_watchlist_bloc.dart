import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_watchlist_event.dart';
part 'tv_series_watchlist_state.dart';

class TvSeriesWatchlistBloc
    extends Bloc<TvSeriesWatchlistEvent, TvSeriesWatchlistState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchlistTvSeries getWatchListsTvSeries;
  final GetWatchListStatusTvSeries getWatchListStatusTvSeries;
  final SaveWatchlistTvSeries saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries removeWatchlistTvSeries;

  TvSeriesWatchlistBloc(
      {required this.getWatchListsTvSeries,
      required this.getWatchListStatusTvSeries,
      required this.saveWatchlistTvSeries,
      required this.removeWatchlistTvSeries})
      : super(TvSeriesWatchlistEmpty()) {
    on<GetListEventTv>((event, emit) async {
      emit(TvSeriesWatchlistLoading());
      final result = await getWatchListsTvSeries.execute();

      result.fold(
        (failure) {
          emit(TvSeriesWatchlistError(failure.message));
        },
        (data) {
          emit(TvSeriesWatchlistHasData(data));
        },
      );
    });

    on<GetStatusTvSeriesEvent>((event, emit) async {
      final id = event.id;
      final result = await getWatchListStatusTvSeries.execute(id);

      emit(TvSeriesWatchlistStatusHasData(result));
    });

    on<AddItemTvSeriesEvent>((event, emit) async {
      final tvDetail = event.tvSeriesDetail;
      final result = await saveWatchlistTvSeries.execute(tvDetail);

      result.fold(
        (failure) {
          emit(TvSeriesWatchlistError(failure.message));
        },
        (successMessage) {
          emit(TvSeriesWatchlistSuccess(successMessage));
        },
      );
    });

    on<RemoveItemTvSeriesEvent>((event, emit) async {
      final tvDetail = event.tvSeriesDetail;
      final result = await removeWatchlistTvSeries.execute(tvDetail);

      result.fold(
        (failure) {
          emit(TvSeriesWatchlistError(failure.message));
        },
        (successMessage) {
          emit(TvSeriesWatchlistSuccess(successMessage));
        },
      );
    });
  }
}
