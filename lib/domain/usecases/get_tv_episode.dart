import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';

import '../entities/episode.dart';
import '../repositories/tv_series_repository.dart';

class GetTvEpisode {
  final TvSeriesRepository repository;

  GetTvEpisode(this.repository);

  Future<Either<Failure, List<Episode>>> execute(int idTv, int idEpisode) {
    return repository.getTvEpisode(idTv, idEpisode);
  }
}
