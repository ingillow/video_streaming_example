import 'package:equatable/equatable.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

abstract class VideoState extends Equatable {}

class VideoInitialState extends VideoState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class VideoLoading extends VideoState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class VideosListStateLoaded extends VideoState {
  final List<VlcPlayerController> controllers;

  VideosListStateLoaded(this.controllers);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SingleVideoState extends VideoState {
  final VlcPlayerController controller;

  SingleVideoState(this.controller);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class VideoError extends VideoState{
 final String messages;
 VideoError(this.messages);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}