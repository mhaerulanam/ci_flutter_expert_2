import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv_series.dart';

part 'tv_series_top_rated_event.dart';
part 'tv_series_top_rated_state.dart';

class TvSeriesTopRatedBloc
    extends Bloc<TvSeriesTopRatedEvent, TvSeriesTopRatedState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TvSeriesTopRatedBloc(this.getTopRatedTvSeries)
      : super(TvSeriesTopRatedEmpty()) {
    on<TvSeriesTopRatedGetEvent>((event, emit) async {
      emit(TvSeriesTopRatedLoading());
      final result = await getTopRatedTvSeries.execute();

      result.fold(
        (failure) {
          emit(TvSeriesTopRatedError(failure.message));
        },
        (data) {
          emit(TvSeriesTopRatedHasData(data));
        },
      );
    });
  }
}
