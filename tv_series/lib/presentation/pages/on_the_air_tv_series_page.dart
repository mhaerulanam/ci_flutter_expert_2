import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/tv/tv_on_the_air/tv_on_the_air_bloc.dart';
import 'package:tv_series/presentation/widgets/tv_series_card_list.dart';

class OnTheAirTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-the-air-tv-series';

  @override
  _OnTheAirTvSeriesPageState createState() => _OnTheAirTvSeriesPageState();
}

class _OnTheAirTvSeriesPageState extends State<OnTheAirTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvOnTheAirBloc>().add(TvOnTheAirGetEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tv Series Is Airing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvOnTheAirBloc, TvOnTheAirState>(
            builder: (context, state) {
          if (state is TvOnTheAirLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvOnTheAirHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tv = state.result[index];
                return TvSeriesCard(tv);
              },
              itemCount: state.result.length,
            );
          } else if (state is TvOnTheAirError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return const Center(
              key: Key('error_message'),
              child: Text("Error"),
            );
          }
        }),
      ),
    );
  }
}
