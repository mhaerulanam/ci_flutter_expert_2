import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_recommendation_event.dart';
part 'tv_series_recommendation_state.dart';

class TvSeriesRecommendationBloc
    extends Bloc<TvSeriesRecommendationEvent, TvSeriesRecommendationState> {
  final GetTvSeriesRecommendations getTvSeriesRecommendations;

  TvSeriesRecommendationBloc({required this.getTvSeriesRecommendations})
      : super(TvSeriesRecommendationEmpty()) {
    on<GetTvSeriesRecommendationEvent>((event, emit) async {
      final id = event.id;

      emit(TvSeriesRecommendationLoading());
      final result = await getTvSeriesRecommendations.execute(id);

      result.fold(
        (failure) {
          emit(TvSeriesRecommendationError(failure.message));
        },
        (data) {
          emit(TvSeriesRecommendationHasData(data));
        },
      );
    });
  }
}
