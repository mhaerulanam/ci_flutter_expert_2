import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeriesTable = TvSeriesTable(
      id: 254,
      name: "ESPNU Inside the Polls",
      posterPath: null,
      overview: "ESPNU Inside the Polls is a television program that breaks down "
          "the latest college football polls. The program airs every Monday for"
          " one hour from 6pm ET to 7pm ET on ESPNU during the college football"
          " season. Since debuting on September 5, 2005, the host has been ESPNU "
          "signature anchor Mike Hall along with analysis from former head coach "
          "Mike Gottfried and ESPN's Scout's Inc. analyst Todd McShay. "
          "Its official name is ESPNU Inside the Polls presented by Conoco."
          "\n\nThe show was originally named The U:Inside the Polls,"
          " but was changed before the 2006 college football season. "
          "The show breaks down the latest college football polls in contrast to"
          " the performance of those teams on Saturday. ESPNU Inside the Polls "
          "is broadcast at the ESPNU headquarters in Charlotte, North Carolina"
          " and was one of the first studio programs to air on the network."
  );

  final tTvWatchList = TvSeries.watchlist(
      id: 254,
      name: "ESPNU Inside the Polls",
      posterPath: null,
      overview: "ESPNU Inside the Polls is a television program that breaks down "
          "the latest college football polls. The program airs every Monday for"
          " one hour from 6pm ET to 7pm ET on ESPNU during the college football"
          " season. Since debuting on September 5, 2005, the host has been ESPNU "
          "signature anchor Mike Hall along with analysis from former head coach "
          "Mike Gottfried and ESPN's Scout's Inc. analyst Todd McShay. "
          "Its official name is ESPNU Inside the Polls presented by Conoco."
          "\n\nThe show was originally named The U:Inside the Polls,"
          " but was changed before the 2006 college football season. "
          "The show breaks down the latest college football polls in contrast to"
          " the performance of those teams on Saturday. ESPNU Inside the Polls "
          "is broadcast at the ESPNU headquarters in Charlotte, North Carolina"
          " and was one of the first studio programs to air on the network."
  );

  test('should be a subclass of Movie entity', () async {
    final result = tSeriesTable.toEntity();
    expect(result, tTvWatchList);
  });
}
