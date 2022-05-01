import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_episode.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvEpisode usecase;
  late MockTvSeriesRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvSeriesRepository();
    usecase = GetTvEpisode(mockTvRepository);
  });

  const tId = 500;
  const tEpisode = 0;

  test('should get episode tv detail from the repository', () async {
    // arrange
    when(mockTvRepository.getTvEpisode(tId, tEpisode))
        .thenAnswer((_) async => Right(testTvEpisodeList));
    // act
    final result = await usecase.execute(tId, tEpisode);
    // assert
    expect(result, Right(testTvEpisodeList));
  });
}
