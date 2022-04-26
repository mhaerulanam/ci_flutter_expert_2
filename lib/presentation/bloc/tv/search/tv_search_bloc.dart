import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTv searchTvSeries;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  TvSearchBloc({required this.searchTvSeries}) : super(TvSearchEmpty()) {
    on<TvOnQueryChange>((event, emit) async {
      final query = event.query;

      emit(TvSearchLoading());
      final result = await searchTvSeries.execute(query);

      result.fold((failure) {
        emit(TvSearchError(failure.message));
      }, (data) {
        emit(TvSearchHasData(data));
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
