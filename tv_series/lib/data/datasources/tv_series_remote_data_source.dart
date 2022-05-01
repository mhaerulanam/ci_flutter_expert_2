import 'package:common/common/exception.dart';
import 'package:http/http.dart' as http;
import 'package:tv_series/data/models/episode_response.dart';
import 'package:tv_series/data/models/tv_series_model.dart';
import 'package:tv_series/data/models/tv_series_response.dart';

import '../models/tv_series_detail_model.dart';

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getTvOnTheAir();
  Future<List<TvSeriesModel>> getPopularTvSeries();
  Future<List<TvSeriesModel>> getTopRatedTvSeries();
  Future<DetailTvSeriesModel> getTvSeriesDetail(int id);
  Future<List<TvSeriesModel>> getTvSeriesRecommendations(int id);
  Future<EpisodeResponse> getTvEpisode(int idTv, int season);
  Future<List<TvSeriesModel>> searchTv(String query);
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  static const API_KEY = 'api_key=3a58e4d37532f1d71684e4c31ffde139';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TvSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvSeriesModel>> getTvOnTheAir() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(response.body).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getPopularTvSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(response.body).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedTvSeries() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(response.body).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<DetailTvSeriesModel> getTvSeriesDetail(int idTv) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$idTv?$API_KEY'));

    if (response.statusCode == 200) {
      return DetailTvSeriesModel.fromJson(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTvSeriesRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(response.body).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> searchTv(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(response.body).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<EpisodeResponse> getTvEpisode(int idTv, int season) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$idTv/season/$season?$API_KEY'));

    if (response.statusCode == 200) {
      return EpisodeResponse.fromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
