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
  YoutubeAPI youtube = YoutubeAPI(apiKey);
  List<YouTubeVideo> videoResult = [];
  Future<void> search() async {
    videoResult = await youtube.search(searchInput.text,
        order: 'relevance', videoDuration: 'any');
    emit(YoutubeSearchState());
  }
}
