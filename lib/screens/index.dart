import 'package:flutter/material.dart';
import 'package:flutter_app/models/item_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Item> items = [
    Item(
      name: 'Forest',
      audioPath: 'audios/forest.mp3',
      imagePath: 'images/forest.jpeg',
    ),
    Item(
      name: 'Night',
      audioPath: 'audios/night.mp3',
      imagePath: 'images/night.jpeg',
    ),
    Item(
      name: 'Ocean',
      audioPath: 'audios/ocean.mp3',
      imagePath: 'images/ocean.jpeg',
    ),
    Item(
      name: 'Waterfall',
      audioPath: 'audios/waterfall.mp3',
      imagePath: 'images/waterfall.jpeg',
    ),
    Item(
      name: 'Wind',
      audioPath: 'audios/wind1.mp3',
      imagePath: 'images/wind.jpeg',
    ),
  ];

  final AudioPlayer audioPlayer = AudioPlayer();

  int? playingIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(items[index].imagePath),
                  ),
                ),
                child: ListTile(
                  title: Text(items[index].name),
                  leading: IconButton(
                    icon: FaIcon(
                      playingIndex == index
                          ? FontAwesomeIcons.stop
                          : FontAwesomeIcons.play,
                    ),
                    onPressed: () async {
                      if (playingIndex == index) {
                        setState(() {
                          playingIndex = null;
                        });
                        audioPlayer.stop();
                      } else {
                        try {
                          await audioPlayer
                              .setAsset(items[index].audioPath)
                              .catchError((onError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red.withOpacity(
                                      0.5,
                                    ),
                                    content: Text('Oops, something went wrong'),
                                  ),
                                );
                              });
                          audioPlayer.play();

                          setState(() {
                            playingIndex = index;
                          });
                        } catch (error) {
                          print(error);
                        }
                      }
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
