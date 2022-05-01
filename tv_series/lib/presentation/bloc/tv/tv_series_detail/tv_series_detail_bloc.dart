import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';

import '../../../../domain/usecases/get_tv_series_detail.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvSeriesDetail getTvDetail;

  TvSeriesDetailBloc({required this.getTvDetail}) : super(TvDetailEmpty()) {
    on<GetTvDetailEvent>((event, emit) async {
      final id = event.id;

      emit(TvDetailLoading());
      final result = await getTvDetail.execute(id);

      result.fold(
        (failure) {
          emit(TvDetailError(failure.message));
        },
        (data) {
          emit(TvDetailHasData(data));
        },
      );
    });
  }
}
