import 'package:common/common/state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:tv_series/domain/usecases/search_tv.dart';

import '../../domain/entities/tv_series.dart';

class TvSearchNotifier extends ChangeNotifier {
  final SearchTv searchTvs;
  TvSearchNotifier({required this.searchTvs});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _searchResult = [];
  List<TvSeries> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvs.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
