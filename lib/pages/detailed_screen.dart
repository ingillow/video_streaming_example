import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:video_streaming_example/bloc/video_player_bloc/video_bloc.dart';
import 'package:video_streaming_example/bloc/video_player_bloc/video_event.dart';
import 'package:video_streaming_example/bloc/video_player_bloc/video_state.dart';


class DetailedVideoScreen extends StatefulWidget {
  final String path;
  const DetailedVideoScreen({Key? key, required this.path}) : super(key: key);

  @override
  State<DetailedVideoScreen> createState() => _DetailedVideoScreenState();
}

class _DetailedVideoScreenState extends State<DetailedVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Single Video Player'),
      ),
      body: BlocProvider(
        create: (context) =>
            VideoStreamBloc()..add(ShowSingleVideoEvent(widget.path)),
        child: BlocBuilder<VideoStreamBloc, VideoState>(
          builder: (context, state) {
            if (state is VideoLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is VideoError) {
              return const Center(child: Text('Error is occured'));
            } else if (state is SingleVideoState) {
              return Center(
                child: VlcPlayer(
                  controller: state.controller,
                  aspectRatio: 9 / 9,
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
