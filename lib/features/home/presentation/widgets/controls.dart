import '../view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class Controls extends StatelessWidget {
  const Controls({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<HomeViewModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 60,
          color: Colors.white,
          onPressed: () => model.previousSong(),
          icon: Icon(Icons.skip_previous_rounded),
        ),
        StreamBuilder<PlayerState?>(
          stream: model.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;

            return AnimatedSwitcher(
              duration: Duration(milliseconds: 600),
              switchInCurve: Curves.easeInCirc,
              switchOutCurve: Curves.easeInExpo,
              child: (!(playing ?? false))
                  ? IconButton(
                      onPressed: model.playAudio,
                      iconSize: 80,
                      color: Colors.white,
                      icon: Icon(
                        Icons.play_arrow_rounded,
                      ),
                    )
                  : (processingState != ProcessingState.completed)
                      ? IconButton(
                          onPressed: model.pauseAudio,
                          iconSize: 80,
                          color: Colors.white,
                          icon: Icon(
                            Icons.pause_rounded,
                          ),
                        )
                      : Icon(
                          Icons.play_arrow_rounded,
                          size: 80,
                          color: Colors.white,
                        ),
            );
          },
        ),
        IconButton(
          iconSize: 60,
          color: Colors.white,
          onPressed: () => model.nextSong(),
          icon: Icon(Icons.skip_next_rounded),
        ),
      ],
    );
  }
}
