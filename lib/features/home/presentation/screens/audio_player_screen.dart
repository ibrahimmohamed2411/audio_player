import 'package:audioplayer/core/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';
import '../view_models/home_view_model.dart';
import '../widgets/controls.dart';
import '../widgets/custom_progress_bar.dart';
import '../widgets/media_meta_data.dart';

class AudioPlayerWidget extends StatelessWidget {
  const AudioPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomContainer(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.h,
        ),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: CustomScrollView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: StreamBuilder<SequenceState?>(
                  stream: context.read<HomeViewModel>().sequenceStateStream,
                  builder: (context, snapshot) {
                    final state = snapshot.data;
                    if (state?.sequence.isEmpty ?? true) {
                      return SizedBox.shrink();
                    }
                    if (snapshot.hasData) {
                      final metaData = state!.currentSource!.tag as MediaItem;

                      return MediaMetaData(
                        artist: metaData.artist ?? '',
                        imageUrl: metaData.artUri.toString(),
                        title: metaData.title,
                        id: 1,
                      );
                    }
                    return Text('Error');
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 20.h,
                ),
              ),
              SliverToBoxAdapter(
                child: CustomProgressBar(),
              ),
              SliverToBoxAdapter(
                child: Controls(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
