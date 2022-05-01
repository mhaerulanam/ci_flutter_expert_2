import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series.dart';

import '../../../../domain/usecases/get_tv_on_the_air.dart';

part 'tv_on_the_air_event.dart';
part 'tv_on_the_air_state.dart';

class TvOnTheAirBloc extends Bloc<TvOnTheAirEvent, TvOnTheAirState> {
  final GetTvOnTheAir getTvOnTheAir;

  TvOnTheAirBloc(this.getTvOnTheAir) : super(TvOnTheAirEmpty()) {
    on<TvOnTheAirEvent>((event, emit) async {
      emit(TvOnTheAirLoading());
      final result = await getTvOnTheAir.execute();

      result.fold(
        (failure) {
          emit(TvOnTheAirError(failure.message));
        },
        (data) {
          emit(TvOnTheAirHasData(data));
        },
      );
    });
  }
}
