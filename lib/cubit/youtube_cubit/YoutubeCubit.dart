import 'dart:developer';

import 'package:drive_music/cubit/youtube_cubit/YoutubeStates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeCubit extends Cubit<YoutubeStates> {
  YoutubeCubit() : super(YoutubeInitState());

  static YoutubeCubit get(context) => BlocProvider.of(context);

  TextEditingController searchInput = TextEditingController();
  static String apiKey = "AIzaSyCf_paCAaTAp-EE780Te6NSKgBsa71i-Xg";
  YoutubeAPI youtube = YoutubeAPI(apiKey, maxResults: 20, type: 'video');
  List<YouTubeVideo> videoResult = [];
  Future<void> search() async {
    await youtube
        .search(searchInput.text, order: 'relevance', videoDuration: 'any')
        .then((value) {
      log(value.toString());
    });
    print(videoResult.length);
    emit(YoutubeSearchState());
  }

  Future<void> getTrend() async {
    videoResult = await youtube.getTrends(regionCode: 'EG');
    emit(YoutubeGetTrendsState());
  }

  List<Widget> streamItem = [];
  List<StreamInfo> streams = [];
  Future<void> getDownloadDetails({required String link}) async {
    streamItem = [];
    var yt = YoutubeExplode();
    var lol = link.substring(32, link.length);
    // log(lol);
    var manifest = await yt.videos.streamsClient.getManifest(lol).then((value) {
      streams = value.streams;
      value.streams.forEach(
        (element) {
          // if (element.container.name == "mp4" ||
          //     element.container.name == 'webm') {
          if (element.container.name == 'webm') {
            print(element.qualityLabel.toString());
            streamItem.add(
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(border: Border.all(width: 0.4)),
                child: Column(children: [
                  Text(element.container.name),
                  Text(
                      "${element.bitrate.kiloBitsPerSecond.toInt().toString()} K")
                ]),
              ),
            );
          } //else {
          //       streamItem.add(
          //         Container(
          //           width: 40,
          //           height: 40,
          //           decoration: BoxDecoration(border: Border.all(width: 0.4)),
          //           child: Column(children: [
          //             Text(element.container.name),
          //             Text(element.qualityLabel),
          //             Text("${element.size.totalMegaBytes.toStringAsFixed(1)} MB")
          //           ]),
          //         ),
          //       );
          //     }
          //   }
        },
      );
      emit(YoutubeGetStreamsSuccessState());
    }).catchError((onError) {
      log(onError.toString());
      emit(YoutubeGetStreamsErrorState());
    });

    // log(manifest as String);
    // var stream = yt.videos.streamsClient.get(streamInfo);
  }
}
