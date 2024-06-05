import 'package:example/bloc_pagination/model/movie.dart';
import 'package:example/bloc_pagination/repository/movie_repository.dart';
import 'package:example/bloc_pagination/service/movie_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_components/flutter_ui_components.dart';

class DemoBlocPaginationPage extends StatefulWidget {
  const DemoBlocPaginationPage({super.key});

  @override
  State<DemoBlocPaginationPage> createState() => _DemoBlocPaginationPageState();
}

class _DemoBlocPaginationPageState extends State<DemoBlocPaginationPage> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => MovieRepository(service: MovieService()),
      child: BlocProvider(
        create: (context) => FetchListBloc<Movie>(
          fetchListItems: context.read<MovieRepository>().fetchPopularMovies,
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('BlocPagination'),
          ),
          body: CustomListView<Movie>(
            itemBuilder: (context, index, item) {
              return ListTile(
                title: Text(
                  item.title,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
