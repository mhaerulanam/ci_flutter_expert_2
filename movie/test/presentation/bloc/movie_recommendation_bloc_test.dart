import 'package:bloc_test/bloc_test.dart';
import 'package:common/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/presentation/bloc/movie/movie_recommendation/movie_recommendation_bloc.dart';

import '../../helpers/test_helper.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
main() {
  late MockGetMovieRecommendations mockGetMovieRecommendation;
  late MovieRecommendationBloc movieRecommendationBloc;

  setUp(() {
    mockGetMovieRecommendation = MockGetMovieRecommendations();
    movieRecommendationBloc = MovieRecommendationBloc(
      getMovieRecommendations: mockGetMovieRecommendation,
    );
  });

  test("initial state should be empty", () {
    expect(movieRecommendationBloc.state, MovieRecommendationEmpty());
  });

  const tMovieId = 1;
  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendation.execute(tMovieId))
          .thenAnswer((_) async => Right(tMovieList));
      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(const GetMovieRecommendationEvent(tMovieId)),
    expect: () =>
    [MovieRecommendationLoading(), MovieRecommendationHasData(tMovieList)],
    verify: (bloc) {
      verify(mockGetMovieRecommendation.execute(tMovieId));
    },
  );

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'Should emit [Loading, Error] when get recommendation is unsuccessful',
    build: () {
      when(mockGetMovieRecommendation.execute(tMovieId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(const GetMovieRecommendationEvent(tMovieId)),
    expect: () => [
      MovieRecommendationLoading(),
      const MovieRecommendationError('Server Failure')
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendation.execute(tMovieId));
    },
  );
}