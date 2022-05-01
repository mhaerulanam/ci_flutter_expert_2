import 'package:common/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import '../entities/episode.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getTvOnTheAir();
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries();
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries();
  Future<Either<Failure, DetailTvSeries>> getTvSeriesDetail(int id);
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommendations(int id);
  Future<Either<Failure, String>> saveWatchlistTvSeries(DetailTvSeries movie);
  Future<Either<Failure, String>> removeWatchlistTvSeries(DetailTvSeries movie);
  Future<bool> isAddedToWatchlistTvSeries(int id);
  Future<Either<Failure, List<TvSeries>>> getWatchlistTvSeries();
  Future<Either<Failure, List<Episode>>> getTvEpisode(int idTv, int idEpisode);
  Future<Either<Failure, List<TvSeries>>> searchTv(String query);
}
