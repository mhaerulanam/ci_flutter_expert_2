import 'package:common/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';

class GetTvOnTheAir {
  final TvSeriesRepository repository;

  GetTvOnTheAir(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getTvOnTheAir();
  }
}
