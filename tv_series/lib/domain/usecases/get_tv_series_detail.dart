import 'package:common/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';

import '../entities/tv_series_detail.dart';

class GetTvSeriesDetail {
  final TvSeriesRepository repository;

  GetTvSeriesDetail(this.repository);

  Future<Either<Failure, DetailTvSeries>> execute(int id) {
    return repository.getTvSeriesDetail(id);
  }
}
