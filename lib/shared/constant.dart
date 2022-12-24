import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';

Widget VideoItem({required YouTubeVideo video}) {
  return Container(
    width: double.infinity,
    height: 175,
    decoration: BoxDecoration(color: Colors.grey[200]),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [Image.network(video.thumbnail.high.url as String)],
      ),
    ),
  );
}
