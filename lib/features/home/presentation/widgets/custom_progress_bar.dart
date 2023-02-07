import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/position_data.dart';
import '../view_models/home_view_model.dart';

class CustomProgressBar extends StatelessWidget {
  const CustomProgressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PositionData>(
      stream: context.read<HomeViewModel>().positionDataStream,
      builder: (context, snapshot) {
        final positionData = snapshot.data;
        return ProgressBar(
          barHeight: 8,
          baseBarColor: Colors.grey[600],
          bufferedBarColor: Colors.grey,
          progressBarColor: Colors.red,
          thumbColor: Colors.red,
          timeLabelTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          progress: positionData?.position ?? Duration.zero,
          buffered: positionData?.bufferedPosition ?? Duration.zero,
          total: positionData?.duration ?? Duration.zero,
          onSeek: context.read<HomeViewModel>().seek,
        );
      },
    );
  }
}
