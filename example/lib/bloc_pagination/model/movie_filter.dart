import 'package:flutter_ui_components/flutter_ui_components.dart';

class MovieFilter extends Filter {
  const MovieFilter({required this.type});

  final MovieType type;
}

enum MovieType {
  popular('popular'),
  topRated('top_rated'),
  upcoming('upcoming'),
  nowPlaying('now_playing');

  const MovieType(this.name);
  final String name;
}
