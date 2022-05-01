import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart' as tail;
import 'package:tv_series/data/datasources/db/database_helper_tv_series.dart';
import 'package:tv_series/data/datasources/tv_series_local_data_source.dart';
import 'package:tv_series/data/datasources/tv_series_remote_data_source.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';
import 'package:tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:tv_series/domain/usecases/get_tv_episode.dart';
import 'package:tv_series/domain/usecases/get_tv_on_the_air.dart';
import 'package:tv_series/domain/usecases/get_tv_series_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_recommendations.dart';
import 'package:tv_series/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:tv_series/domain/usecases/get_watchlist_tv_series.dart';
import 'package:tv_series/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:tv_series/domain/usecases/save_watchlist_tv_series.dart';
import 'package:tv_series/domain/usecases/search_tv.dart';
import 'package:tv_series/presentation/bloc/tv/tv_on_the_air/tv_on_the_air_bloc.dart';
import 'package:tv_series/presentation/bloc/tv/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv/tv_series_episode/tv_series_episode_bloc.dart';
import 'package:tv_series/presentation/bloc/tv/tv_series_popular/tv_series_popular_bloc.dart';
import 'package:tv_series/presentation/bloc/tv/tv_series_recommendation/tv_series_recommendation_bloc.dart';
import 'package:tv_series/presentation/bloc/tv/tv_series_top_rated/tv_series_top_rated_bloc.dart';
import 'package:tv_series/presentation/bloc/tv/tv_series_watchlist/tv_series_watchlist_bloc.dart';

class MockTvSeriesWatchlistBloc
    extends MockBloc<TvSeriesWatchlistEvent, TvSeriesWatchlistState>
    implements TvSeriesWatchlistBloc {}

class TvSeriesWatchlistEventFake extends tail.Fake implements TvSeriesWatchlistEvent {}

class TvSeriesWatchlistStateFake extends tail.Fake implements TvSeriesWatchlistState {}

class MockTvRecommendationBloc
    extends MockBloc<TvSeriesRecommendationEvent, TvSeriesRecommendationState>
    implements TvSeriesRecommendationBloc {}

class TvRecommendationEventFake extends tail.Fake
    implements TvSeriesRecommendationEvent {}

class TvRecommendationStateFake extends tail.Fake
    implements TvSeriesRecommendationState {}

class MockTvDetailBloc extends MockBloc<TvSeriesDetailEvent, TvSeriesDetailState>
    implements TvSeriesDetailBloc {}

class TvDetailEventFake extends tail.Fake implements TvSeriesDetailEvent {}

class TvDetailStateFake extends tail.Fake implements TvSeriesDetailState {}

class MockTvEpisodeBloc extends MockBloc<TvSeriesEpisodeEvent, TvSeriesEpisodeState>
    implements TvSeriesEpisodeBloc {}

class TvEpisodeEventFake extends tail.Fake implements TvSeriesEpisodeEvent {}

class TvEpisodeStateFake extends tail.Fake implements TvSeriesEpisodeState {}

class MockTvPopularBloc extends MockBloc<TvSeriesPopularEvent, TvSeriesPopularState>
    implements TvSeriesPopularBloc {}

class TvPopularEventFake extends tail.Fake implements TvSeriesPopularEvent {}

class TvPopularStateFake extends tail.Fake implements TvSeriesPopularState {}


class MockTvTopRatedBloc extends MockBloc<TvSeriesTopRatedEvent, TvSeriesTopRatedState>
    implements TvSeriesTopRatedBloc {}

class TvTopRatedEventFake extends tail.Fake implements TvSeriesTopRatedEvent {}

class TvTopRatedStateFake extends tail.Fake implements TvSeriesTopRatedState {}

class MockTvOnTheAirBloc extends MockBloc<TvOnTheAirEvent, TvOnTheAirState>
    implements TvOnTheAirBloc {}

class TvOnTheAirEventFake extends tail.Fake implements TvOnTheAirEvent {}

class TvOnTheAirStateFake extends tail.Fake implements TvOnTheAirState {}

class MockTvNowPlayingBloc
    extends MockBloc<TvOnTheAirEvent, TvOnTheAirState>
    implements TvOnTheAirBloc {}

class TvNowPlayingEventFake extends tail.Fake implements TvOnTheAirEvent {}

class TvNowPlayingStateFake extends tail.Fake implements TvOnTheAirState {}

@GenerateMocks([
  TvSeriesRepository,
  TvSeriesRemoteDataSource,
  TvSeriesLocalDataSource,
  DatabaseHelperTvSeries,
  GetWatchListStatusTvSeries,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
  GetPopularTvSeries,
  GetTopRatedTvSeries,
  GetTvEpisode,
  GetTvSeriesDetail,
  GetTvSeriesRecommendations,
  GetTvOnTheAir,
  SearchTv,
  GetWatchlistTvSeries,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
