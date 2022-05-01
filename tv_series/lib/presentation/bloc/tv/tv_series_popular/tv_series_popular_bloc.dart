import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_popular_tv_series.dart';

part 'tv_series_popular_event.dart';
part 'tv_series_popular_state.dart';

class TvSeriesPopularBloc
    extends Bloc<TvSeriesPopularEvent, TvSeriesPopularState> {
  final GetPopularTvSeries getPopularTvSeries;

  TvSeriesPopularBloc(this.getPopularTvSeries) : super(TvSeriesPopularEmpty()) {
    on<TvSeriesPopularEvent>((event, emit) async {
      emit(TvSeriesPopularLoading());
      final result = await getPopularTvSeries.execute();

      result.fold(
        (failure) {
          emit(TvSeriesPopularError(failure.message));
        },
        (data) {
          emit(TvSeriesPopularHasData(data));
        },
      );
    });
  }
}
