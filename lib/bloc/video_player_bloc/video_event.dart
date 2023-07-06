import 'package:equatable/equatable.dart';

abstract class VideoEvent extends Equatable {}

class ShowVideosListEvent extends VideoEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ShowSingleVideoEvent extends VideoEvent {
  final String path;

  ShowSingleVideoEvent(this.path);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
