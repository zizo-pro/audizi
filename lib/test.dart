import 'dart:developer';

import 'package:audiotagger/audiotagger.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'dart:io';
import 'dart:ui';
import "package:ffmpeg_kit_flutter_audio/ffmpeg_kit.dart";

Future<void> maestro() async {
  // tag();
  var yt = YoutubeExplode();
  // var streamInfo = await yt.videos.streamsClient.getManifest('fRh_vgS2dFE');
  var manifest = await yt.videos.streamsClient.getManifest('pRpeEdMmmQ0');
  var streamInfo = manifest.audioOnly.withHighestBitrate();
  var stream = yt.videos.streamsClient.get(streamInfo);
  var file =
      File("/storage/emulated/0/Download/sond.${streamInfo.container.name}");
  var fileStream = file.openWrite(mode: FileMode.writeOnlyAppend);
  var count = 0;
  var len = streamInfo.size.totalBytes;
  await for (final data in stream) {
    count += data.length;
    var progress = ((count / len) * 100).ceil();
    log("$progress");
    fileStream.add(data);
  }
  ;
  await fileStream.close();

  // FFmpegKit.execute(
  //         "-i /storage/emulated/0/Download/sond.webm -vn -q:a 0 -map a /storage/emulated/0/Download/sond.mp3")
  //     .then((value) async {
  //       print("done");
  //   // final returnCode = await value.getReturnCode();
  //     tag();

  // }).catchError((onError) {
  //   print(onError.toString());
  // });
  // Close the YoutubeExplode's http client.
  // yt.close();
}

void tag() async {
  final tagger = Audiotagger();

  final path = "/storage/emulated/0/Download/sond.mp3";
  final tags = <String, String>{
    "title": "ziad",
    "artist": "a fake artist",
    "album": '',
  };
  log("here");

  final result =
      await tagger.writeTagsFromMap(path: path, tags: tags).then((value) {
    print("done");
  }).onError((error, stackTrace) {
    log(error.toString());
  });
}
