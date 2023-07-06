import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:video_streaming_example/bloc/auth_firebase_bloc/auth_event.dart';
import 'package:video_streaming_example/bloc/auth_firebase_bloc/bloc_auth.dart';
import 'package:video_streaming_example/bloc/video_player_bloc/video_bloc.dart';
import 'package:video_streaming_example/bloc/video_player_bloc/video_event.dart';
import 'package:video_streaming_example/bloc/video_player_bloc/video_state.dart';
import 'package:video_streaming_example/pages/detailed_screen.dart';
import 'package:video_streaming_example/pages/home_page.dart';

class MosaicPlayerRtsp extends StatefulWidget {
  const MosaicPlayerRtsp({Key? key}) : super(key: key);

  @override
  State<MosaicPlayerRtsp> createState() => _MosaicPlayerRtspState();
}

class _MosaicPlayerRtspState extends State<MosaicPlayerRtsp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RTSP'),
      ),
      body: BlocProvider(
        create: (context) => VideoStreamBloc()..add(ShowVideosListEvent()),
        child: BlocBuilder<VideoStreamBloc, VideoState>(
          builder: (context, state) {
            if (state is VideoLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is VideoError) {
              return const Center(child: Text('Error is occured'));
            } else if (state is VideosListStateLoaded) {
              return GridView.builder(
                itemCount: state.controllers.length,
                itemBuilder: (context, index) {
                  var controllerState = state.controllers[index];
                  if (controllerState.value.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.black12,
                        width: 200,
                        height: 200,
                        child: const Center(
                          child: Text('Something went wrong'),
                        ),
                      ),
                    );
                  }
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetailedVideoScreen(
                              path: state.controllers[index].dataSource),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: VlcPlayer(
                        controller: state.controllers[index],
                        aspectRatio: 9 / 9,
                      ),
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
              );
            };
            return Container(
              color: Colors.grey,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          BlocProvider.of<AuthBloc>(context).add(
            SignOutEvent(),
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        },
        label: const Text('Sign out'),
        icon: const Icon(Icons.logout),
      ),
    );
  }
}
