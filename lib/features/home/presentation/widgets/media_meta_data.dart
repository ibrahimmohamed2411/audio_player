import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
class MediaMetaData extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String artist;
  final int id;
  const MediaMetaData({
    super.key,
    required this.artist,
    this.imageUrl,
    required this.title,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(2, 4),
                blurRadius: 4,
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: imageUrl != null
                ? QueryArtworkWidget(
                    id: 1,
                    type: ArtworkType.AUDIO,
                  )
                : Image.asset(
                    'assets/images/music.gif',
                  ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          artist,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
