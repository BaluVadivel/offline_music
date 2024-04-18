import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:offline_music/helper/audio_helper.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayingNowScreen extends StatelessWidget {
  PlayingNowScreen(Map? args, {super.key}) {
    if (args is Map && args["song"] is SongModel) {
      song = args["song"];
    } else {
      song = null;
    }
  }

  late final SongModel? song;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        // width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFf35b28),
            Color(0xFFefc127),
            Color(0xFFefc127),
            Color(0xFFefc127),
            Color(0xFFefc127),
            Color(0xFFefc127),
          ],
        )),
        child: CustomPaint(
          painter: TempPainter(),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LayoutBuilder(builder: (context, boxConstraints) {
                  final totalHeight = MediaQuery.of(context).size.height;
                  final size = boxConstraints.maxWidth * 0.8;
                  final temp =
                      size > (totalHeight / 1.6) ? totalHeight / 1.6 : size;
                  return QueryArtworkWidget(
                    artworkWidth: temp,
                    artworkHeight: temp,
                    id: song?.id ?? 0,
                    type: ArtworkType.AUDIO,
                    artworkBorder: BorderRadius.circular(8),
                  );
                }),
                const SizedBox(height: 36),
                Text(
                  song?.displayNameWOExt ?? "",
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 20),
                Text(
                  song?.composer ?? "",
                  style: const TextStyle(color: Colors.white70, fontSize: 19),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFf27828), width: 8),
                          borderRadius: BorderRadius.circular(60)),
                      child: StreamBuilder<PlayerState>(
                          stream: audioPlayer.playerStateStream,
                          builder: (context, snapshot) {
                            final playerState = snapshot.data;
                            final processingState =
                                playerState?.processingState;
                            IconData icon = Icons.replay;
                            VoidCallback? onPressed;
                            if (processingState == ProcessingState.loading ||
                                processingState == ProcessingState.buffering) {
                              icon = Icons.play_arrow_rounded;
                            } else if (playerState?.playing != true) {
                              icon = Icons.play_arrow_rounded;
                              onPressed = audioPlayer.play;
                            } else if (processingState !=
                                ProcessingState.completed) {
                              icon = Icons.pause_rounded;
                              onPressed = audioPlayer.pause;
                            }
                            return IconButton(
                                onPressed: onPressed,
                                icon: Icon(
                                  icon,
                                  size: 60,
                                  color: const Color(0xFFf27828),
                                ));
                          }),
                    ),
                    const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class TempPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final paint = Paint();
    paint.shader = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF1c1a58),
        Color(0xFF1c1a58),
        Color(0xFF101042),
      ],
    ).createShader(Rect.fromPoints(const Offset(0, 0), Offset(width, height)));

    canvas.drawCircle(Offset(width / 2, height), height * .75, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
