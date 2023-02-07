import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/position_data.dart';
import '../view_models/home_view_model.dart';

class MiniAudioPlayerView extends StatefulWidget {
  const MiniAudioPlayerView({super.key});

  @override
  State<MiniAudioPlayerView> createState() => _MiniAudioPlayerViewState();
}

class _MiniAudioPlayerViewState extends State<MiniAudioPlayerView> {
  @override
  void initState() {
    context.read<HomeViewModel>().currentAudioSongStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 2.h,
      ),
      child: Column(
        children: [
          Row(
            children: [
              QueryArtworkWidget(
                artworkWidth: 40.w,
                artworkHeight: 40.h,
                id: context.read<HomeViewModel>().currentSong!.id,
                type: ArtworkType.AUDIO,
                errorBuilder: (p0, p1, p2) => Image.asset(
                  'assets/images/music.gif',
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Expanded(
                child: Text(
                  context.read<HomeViewModel>().currentSong!.displayName,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.red,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              StreamBuilder<bool?>(
                  stream: context.read<HomeViewModel>().playingStateStream,
                  builder: (context, snapshot) {
                    final playing = snapshot.data;
                    if (playing == true) {
                      return IconButton(
                        onPressed: () {
                          context.read<HomeViewModel>().pauseAudio();
                        },
                        icon: Icon(
                          Icons.pause,
                          color: Colors.red,
                        ),
                      );
                    }

                    return IconButton(
                      onPressed: () {
                        context.read<HomeViewModel>().playAudio();
                      },
                      icon: Icon(
                        Icons.play_arrow,
                        color: Colors.red,
                      ),
                    );
                  }),
              IconButton(
                onPressed: () {
                  context.read<HomeViewModel>().closePlayer();
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          Flexible(
            child: StreamBuilder<PositionData>(
              stream: context.read<HomeViewModel>().positionDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                if (positionData == null ||
                    positionData.duration == Duration.zero) {
                  return SizedBox.shrink();
                }
                return LinearProgressIndicator(
                  color: Colors.red,
                  value: positionData.position.inMilliseconds /
                      positionData.duration.inMilliseconds,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
