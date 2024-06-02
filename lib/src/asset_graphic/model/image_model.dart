import 'package:equatable/equatable.dart';

abstract class ImageModel extends Equatable {
  const ImageModel({
    required this.path,
    this.package,
  });

  final String path;
  final String? package;

  @override
  List<Object?> get props => [
        path,
        package,
      ];
}
