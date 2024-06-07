import 'package:example/bloc_pagination/model/movie.dart';
import 'package:example/bloc_pagination/model/movie_filter.dart';
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
          fetchListItems: (page, filter) {
            return context.read<MovieRepository>().fetchPopularMovies(page, filter);
          },
          filter: const MovieFilter(type: MovieType.topRated),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('BlocPagination'),
          ),
          body: Column(
            children: [
              const SizedBox(height: 120, child: Placeholder()),
              Expanded(
                child: CustomListView<Movie>(
                  itemBuilder: (context, index, item) {
                    return ListTile(
                      title: Text(
                        item.title,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
