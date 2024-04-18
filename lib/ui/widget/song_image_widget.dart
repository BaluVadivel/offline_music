import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongImageWidget extends StatelessWidget {
  const SongImageWidget(this.id, {super.key});

  final int id;

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      id: id,
      type: ArtworkType.AUDIO,
      artworkBorder: BorderRadius.circular(8),
    );
  }
}
