import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class NetworkAudioPlayerWidget extends StatefulWidget {
  final String audioUrl;
  final VoidCallback farwordOntap;
  final VoidCallback backOntap;

  const NetworkAudioPlayerWidget({
    super.key,
    required this.audioUrl,
    required this.farwordOntap,
    required this.backOntap,
  });

  @override
  State<NetworkAudioPlayerWidget> createState() =>
      _NetworkAudioPlayerWidgetState();
}

class _NetworkAudioPlayerWidgetState extends State<NetworkAudioPlayerWidget> {
  late AudioPlayer _player;

  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _init();
  }

  Future<void> _init() async {
    if (widget.audioUrl.isEmpty) {
      setState(() => _isLoading = false);
      return;
    }

    try {
      await _player.setUrl(widget.audioUrl);

      _player.durationStream.listen((d) {
        if (d != null) {
          setState(() => _duration = d);
        }
      });

      _player.positionStream.listen((p) {
        setState(() => _position = p);
      });
    } catch (e) {
      debugPrint("Audio load error: $e");
    }

    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(1, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    if (widget.audioUrl.isEmpty) {
      return const SizedBox();
    }

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xfff2f2f2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// PROGRESS BAR
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 3,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
            ),
            child: Slider(
              activeColor: const Color(0xff1f3c88),
              inactiveColor: Colors.grey.shade400,
              min: 0,
              max: _duration.inSeconds.toDouble(),
              value:
                  _position.inSeconds.clamp(0, _duration.inSeconds).toDouble(),
              onChanged: (value) async {
                final newPosition = Duration(seconds: value.toInt());
                await _player.seek(newPosition);
              },
            ),
          ),

          /// TIME ROW
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDuration(_position),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                Text(
                  _formatDuration(_duration),
                  style: const TextStyle(
                    color: Color(0xff1f3c88),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// CONTROL BUTTONS
          StreamBuilder<PlayerState>(
            stream: _player.playerStateStream,
            builder: (context, snapshot) {
              final playing = snapshot.data?.playing ?? false;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /// PREVIOUS (Seek -10 sec)
                  IconButton(
                      icon: const Icon(
                        Icons.skip_previous,
                        color: Colors.grey,
                        size: 28,
                      ),
                      onPressed: widget.backOntap
                      // () async {
                      //   final newPosition =
                      //       _position - const Duration(seconds: 10);
                      //   await _player.seek(
                      //     newPosition > Duration.zero
                      //         ? newPosition
                      //         : Duration.zero,
                      //   );
                      // },
                      ),

                  /// PLAY / PAUSE (BIG CENTER BUTTON)
                  GestureDetector(
                    onTap: () async {
                      if (playing) {
                        await _player.pause();
                      } else {
                        await _player.play();
                      }
                    },
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: const BoxDecoration(
                        color: Color(0xff1f3c88),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        playing ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),

                  /// NEXT (Seek +10 sec)
                  IconButton(
                      icon: const Icon(
                        Icons.skip_next,
                        color: Color(0xff1f3c88),
                        size: 28,
                      ),
                      onPressed: widget.farwordOntap

                      //  () async {
                      //   final newPosition =
                      //       _position + const Duration(seconds: 10);
                      //   await _player.seek(
                      //     newPosition < _duration ? newPosition : _duration,
                      //   );
                      // },
                      ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
