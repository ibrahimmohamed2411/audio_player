import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';

import '../view_models/home_view_model.dart';
import '../widgets/controls.dart';
import '../widgets/custom_progress_bar.dart';
import '../widgets/media_meta_data.dart';


class AudioPlayerScreen extends StatelessWidget {
  const AudioPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF144771),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 30.w,
          ),
          onPressed: () => context
              .read<HomeViewModel>()
              .controller
              .animateToHeight(state: PanelState.MIN),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.h,
        ),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF144771),
              Color(0xFF071A2C),
            ],
          ),
        ),
        child: Center(
          child: CustomScrollView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: StreamBuilder<SequenceState?>(
                  stream: context
                      .read<HomeViewModel>()
                   
                      .sequenceStateStream,
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
