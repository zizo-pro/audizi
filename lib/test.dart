import 'dart:developer';
import 'dart:io';

import 'package:genius_api_unofficial/genius_api_unofficial.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:googleapis/customsearch/v1.dart';

void test() async {
  // CustomSearchApi(client).cse.list()
  // var client = CustomSearchApi(apiKey: 'AIzaSyC2_zL1vAxpNFWuLVlnMHHZW0R13WnI6U8');
}

// AIzaSyC2_zL1vAxpNFWuLVlnMHHZW0R13WnI6U8

// void get_lyrics({required String artist, required String title}) async {
//   print("pressed here");
//   final response = await http.get(Uri.parse(
//       'https://www.rentanadviser.com/subtitles/getsubtitle.aspx?artist=${artist}&song=${title}'));
//   dom.Document document = parser.parse(response.body);
//   final lyrics = document
//       .getElementById("ctl00_ContentPlaceHolder1_lbllyrics_simple")!
//       .text;
//   var index = lyrics.indexOf("[");
//   _write(lyrics.substring(index, lyrics.length).replaceAll("[", "\n["));
// }

// _write(String text) async {
//   print("this happend");
//   final File directory = File("/storage/emulated/0/Download/test.lrc");
//   await directory.writeAsString(text).then((value) {
//     print(value.path);
//   }).catchError((onError) {
//     print(onError.toString());
//   });
// }









// Future<void> maestro() async {
//   // tag();
//   var yt = YoutubeExplode();
//   // var streamInfo = await yt.videos.streamsClient.getManifest('fRh_vgS2dFE');
//   var manifest = await yt.videos.streamsClient.getManifest('pRpeEdMmmQ0');
//   var streamInfo = manifest.audioOnly.withHighestBitrate();
//   var stream = yt.videos.streamsClient.get(streamInfo);
//   var file =
//       File("/storage/emulated/0/Download/sond.${streamInfo.container.name}");
//   var fileStream = file.openWrite(mode: FileMode.writeOnlyAppend);
//   var count = 0;
//   var len = streamInfo.size.totalBytes;
//   await for (final data in stream) {
//     count += data.length;
//     var progress = ((count / len) * 100).ceil();
//     log("$progress");
//     fileStream.add(data);
//   }
//   ;
//   await fileStream.close();

//   // FFmpegKit.execute(
//   //         "-i /storage/emulated/0/Download/sond.webm -vn -q:a 0 -map a /storage/emulated/0/Download/sond.mp3")
//   //     .then((value) async {
//   //       print("done");
//   //   // final returnCode = await value.getReturnCode();
//   //     tag();

//   // }).catchError((onError) {
//   //   print(onError.toString());
//   // });
//   // Close the YoutubeExplode's http client.
//   // yt.close();
// }

// void tag() async {
//   final tagger = Audiotagger();

//   final path = "/storage/emulated/0/Download/sond.mp3";
//   final tags = <String, String>{
//     "title": "ziad",
//     "artist": "a fake artist",
//     "album": '',
//   };
//   log("here");

//   final result =
//       await tagger.writeTagsFromMap(path: path, tags: tags).then((value) {
//     print("done");
//   }).onError((error, stackTrace) {
//     log(error.toString());
//   });
// }
