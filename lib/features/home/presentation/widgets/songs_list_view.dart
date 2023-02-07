import '../view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class SongsListView extends StatelessWidget {
  const SongsListView({
    super.key,
    required this.songsList,
  });

  final List<SongModel> songsList;

  @override
  Widget build(BuildContext context) {
    return Selector<HomeViewModel, SongModel?>(
      selector: (p0, p1) => p1.currentSong,
      builder: (context, value, child) {
        final model = context.read<HomeViewModel>();
        return Container(
          margin: EdgeInsets.only(bottom: model.currentSong != null ? 60.h : 0),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: songsList.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                context.read<HomeViewModel>().play(index);
              },
              title: Text(
                songsList[index].displayName,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              leading: QueryArtworkWidget(
                id: songsList[index].id,
                type: ArtworkType.AUDIO,
                errorBuilder: (p0, p1, p2) => Image.asset(
                  'assets/images/music.gif',
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
