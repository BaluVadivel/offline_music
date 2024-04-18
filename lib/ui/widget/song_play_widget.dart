import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:offline_music/helper/audio_helper.dart';
import 'package:offline_music/helper/nav_helper.dart';
import 'package:offline_music/ui/widget/song_image_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongPlayWidget extends StatelessWidget {
  const SongPlayWidget(this.e, {super.key});
  final SongModel e;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        openScreen(Path.playingNow, args: {"song": e});
      },
      child: Container(
        height: 76,
        width: double.infinity,
        decoration: const BoxDecoration(color: Color(0xFF191b49)),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Flexible(
              child: Row(
                children: [
                  SongImageWidget(e.id),
                  const SizedBox(width: 18),
                  Flexible(
                    child: Text(
                      e.displayNameWOExt,
                      style: const TextStyle(color: Colors.white, fontSize: 22),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 18),
            StreamBuilder<PlayerState>(
                stream: audioPlayer.playerStateStream,
                builder: (context, snapshot) {
                  final playerState = snapshot.data;
                  final processingState = playerState?.processingState;
                  IconData icon = Icons.replay;
                  VoidCallback? onPressed;
                  if (processingState == ProcessingState.loading ||
                      processingState == ProcessingState.buffering) {
                    icon = Icons.play_arrow_rounded;
                  } else if (playerState?.playing != true) {
                    icon = Icons.play_arrow_rounded;
                    onPressed = audioPlayer.play;
                  } else if (processingState != ProcessingState.completed) {
                    icon = Icons.pause_rounded;
                    onPressed = audioPlayer.pause;
                  }
                  return IconButton(
                      onPressed: onPressed,
                      icon: Icon(
                        icon,
                        size: 40,
                        color: const Color(0xFFf27828),
                      ));
                }),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
