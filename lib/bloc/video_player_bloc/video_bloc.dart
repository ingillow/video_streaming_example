

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:video_streaming_example/bloc/video_player_bloc/video_event.dart';
import 'package:video_streaming_example/bloc/video_player_bloc/video_state.dart';

import '../../models/models.dart';

class VideoStreamBloc extends Bloc<VideoEvent, VideoState>{

  List<Videos> videos = [
    Videos(
      id: 1,
      path:
      'rtsp://zephyr.rtsp.stream/pattern?streamKey=7d3555b36099be257ebc030cb270c80a',
    ),
    Videos(
      id: 2,
      path:
      'rtsp://zephyr.rtsp.stream/movie?streamKey=b3b7be5e46fc030b4eed1a441c8d2b2b',
    ),
    Videos(
      id: 3,
      path: 'http://158.58.130.148/mjpg/video.mjpg',
    ),
  ];

  VideoStreamBloc() : super(VideoInitialState()){
    on<ShowVideosListEvent>((event, emit){
      List<VlcPlayerController> controllers = [];
      for (var i = 0; i < videos.length; i++) {
        var controller = VlcPlayerController.network(
          videos[i].path ?? 'No url',
          autoPlay: true,
          autoInitialize: true,
          hwAcc: HwAcc.auto,
        );
        controllers.add(controller);
      }
      emit(VideosListStateLoaded(controllers));
    });
    on<ShowSingleVideoEvent>((event, emit){
      VlcPlayerController controller = VlcPlayerController.network(
        event.path,
        autoPlay: true,
        autoInitialize: true,
        hwAcc: HwAcc.auto,
      );
      emit(SingleVideoState(controller));
    });
  }
}