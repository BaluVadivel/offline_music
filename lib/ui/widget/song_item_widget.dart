import 'package:flutter/material.dart';
import 'package:offline_music/ui/widget/song_image_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongItemWidget extends StatelessWidget {
  const SongItemWidget(this.e, {super.key});
  final SongModel e;

  String getDuration() {
    final int seconds = (e.duration ?? 0) ~/ 1000;
    final String minutesStr = (seconds ~/ 60).toString().padLeft(2, '0');
    final String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        e.displayNameWOExt,
        style: const TextStyle(color: Colors.white, fontSize: 18),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Row(
        children: [
          Flexible(
            child: Text(
              e.composer ?? "No composer",
              style: const TextStyle(color: Colors.white70, fontSize: 15),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            ' − ${getDuration()}',
            style: const TextStyle(color: Colors.white70, fontSize: 15),
          ),
        ],
      ),
      leading: SongImageWidget(e.id),
    );
  }
}
