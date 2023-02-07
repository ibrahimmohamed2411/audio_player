import '../../../../core/utils/media_query_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../screens/audio_player_screen.dart';
import '../view_models/home_view_model.dart';
import 'mini_audio_player_widget.dart';
class MiniPlayer extends StatelessWidget {
  const MiniPlayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<HomeViewModel, SongModel?>(
      selector: (p0, p1) => p1.currentSong,
      builder: (context, value, child) => Visibility(
        visible: context.read<HomeViewModel>().currentSong != null,
        child: Miniplayer(
          controller: context.read<HomeViewModel>().controller,
          minHeight: 60.h,
          maxHeight: context.height,
          onDismiss: () => context.read<HomeViewModel>().closePlayer(),
          builder: (height, percentage) {
            if (height <= 60.h + 20.h) {
              return MiniAudioPlayerView();
            }
            return Center(child: AudioPlayerScreen());
          },
        ),
      ),
    );
  }
}
