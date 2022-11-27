import 'package:flutter/material.dart';

class PlacementMusicView extends StatefulWidget {
  const PlacementMusicView({super.key});


  @override
  State<PlacementMusicView> createState() => _PlacementMusicViewState();
} 

class _PlacementMusicViewState extends State<PlacementMusicView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Placement Music'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  const <Widget>[
            Text('Placement Music')
          ],
        ),
      ),
    );
  }
}