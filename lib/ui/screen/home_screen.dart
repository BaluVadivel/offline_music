import 'package:flutter/material.dart';
import 'package:offline_music/helper/audio_helper.dart';
import 'package:offline_music/ui/screen/songs_screen.dart';
import 'package:offline_music/ui/widget/song_play_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SongModel? currentSong;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(170, 26, 23, 121),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton:
          currentSong != null ? SongPlayWidget(currentSong!) : null,
      body: Column(
        children: [
          const SizedBox(
            width: double.infinity,
            height: 72,
            child: Row(
              children: [
                SizedBox(width: 26),
                Text(
                  'Offline Music',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1c1a58),
                  Color(0xFF101042),
                  Color(0xFF020527),
                ],
              ),
            ),
            child: SongsScreen(
              (song) async {
                setState(() {
                  currentSong = song;
                });
                await audioPlayer.setUrl(song.uri ?? "");
                audioPlayer.play();
              },
            ),
          )),
        ],
      ),
    ));
  }
}
