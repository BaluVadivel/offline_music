import 'package:flutter/material.dart';
import 'package:offline_music/helper/audio_helper.dart';
import 'package:offline_music/ui/widget/song_item_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class SongsScreen extends StatefulWidget {
  const SongsScreen(this.onSelect, {super.key});
  final void Function(SongModel song) onSelect;

  @override
  State<SongsScreen> createState() => _SongsScreenState();
}

class _SongsScreenState extends State<SongsScreen> {
  List<SongModel> loadedSongs = [];
  bool isLoading = false;
  bool noAccess = false;

  @override
  void initState() {
    loadSongs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: Text("Loading"))
        : noAccess
            ? Center(
                child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                children: [
                  const Text("No access to files"),
                  IconButton(
                      onPressed: loadSongs, icon: const Icon(Icons.refresh))
                ],
              ))
            : ListView.separated(
                padding: const EdgeInsets.only(top: 12),
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemCount: loadedSongs.length,
                itemBuilder: (context, index) => InkWell(
                    key: ValueKey(loadedSongs[index]),
                    onTap: () => widget.onSelect(loadedSongs[index]),
                    child: SongItemWidget(loadedSongs[index])),
              );
  }

  Future<void> loadSongs() async {
    // below 13 is Permission.storage
    // 13+ is Permission.audio
    setState(() {
      isLoading = true;
    });
    debugPrint("checking permission status");
    PermissionStatus permission = await Permission.storage.status;
    if (permission != PermissionStatus.granted) {
      debugPrint("not granted");
      permission = await Permission.storage.request();
      if (permission == PermissionStatus.permanentlyDenied) {
        const SnackBar(content: Text("Media permissions are denied"));
      }
    }
    if (await Permission.storage.status == PermissionStatus.granted) {
      // if (await Permission.audio.status == PermissionStatus.granted) {
      final s = await audioQuery.querySongs();
      setState(() {
        noAccess = false;
        isLoading = false;
        loadedSongs = s;
      });
    } else {
      setState(() {
        noAccess = true;
        isLoading = false;
      });
    }
  }
}
