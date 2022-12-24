// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'dart:developer';
import 'dart:io';
import 'package:audiotagger/audiotagger.dart';
import 'package:drive_music/cubit/downloader_cubit/DownloaderStates.dart';
import 'package:ffmpeg_kit_flutter_audio/ffmpeg_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class DownloaderCubit extends Cubit<DownloadStates> {
  DownloaderCubit() : super(DownloaderInitState());

  static DownloaderCubit get(context) => BlocProvider.of(context);

  TextEditingController linkEntry = TextEditingController();
  List<FileSystemEntity> entities = [];
  String videoName = "";
  String videoArtist = "";
  String imageUrl = "";
  var video;
  int progress = 0;

  Future<void> downloadVideo({required String link}) async {
    var yt = YoutubeExplode();
    
    await yt.videos.get(link).then((value) {
      videoName = value.title;
      value.publishDate!.year;
      videoArtist = value.author;
      imageUrl = value.thumbnails.highResUrl;
      video = value;
      emit(DownloaderLinkEnterState());
    });

    var manifest = await yt.videos.streamsClient.getManifest(link);
    var streamInfo = manifest.audioOnly.withHighestBitrate();
    var stream = yt.videos.streamsClient.get(streamInfo);

    var file =
        File("/storage/emulated/0/Download/sond.${streamInfo.container.name}");
    var fileStream = file.openWrite(mode: FileMode.writeOnlyAppend);
    var count = 0;
    var len = streamInfo.size.totalBytes;
    await for (final data in stream) {
      count += data.length;
      progress = ((count / len) * 100).ceil();
      fileStream.add(data);
      emit(DownloaderProgressBar());
    }
    downloadImage(url: imageUrl, title: videoName);
    await fileStream.close().then((value) => convert(video));
  }

  Future<void> convert(video) async {
    log("started ffmpeg");
    FFmpegKit.execute(
            "-i /storage/emulated/0/Download/sond.webm -vn -map a /storage/emulated/0/Download/sond.mp3")
        .then((value) async {
      log("finished ffmpeg");
      changeFileNameOnly(File("/storage/emulated/0/Download/sond.mp3"),
              "${videoName.toUpperCase()}.mp3")
          .then((value) {})
          .catchError((onError) {
        log(onError.toString());
      });

      // final returnCode = await value.getReturnCode();
    }).catchError((onError) {
      log(onError.toString());
    });
  }

  Future<void> tag({required String path, required String imgPath}) async {
    final tagger = Audiotagger();

    // final path = "/storage/emulated/0/Download/sond.mp3";
    final tags = <String, String>{
      "title": videoName.toUpperCase(),
      "artist": videoArtist.toUpperCase(),
      "album": videoName.toUpperCase(),
      "artwork": imgPath
    };
    log("started tag");

    final result =
        await tagger.writeTagsFromMap(path: path, tags: tags).then((value) {
      log("done tagging");
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }

  Future<void> changeFileNameOnly(File file, String newFileName) async {
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    file.rename(newPath).then((value) {
      log("finished renaming");
      File("/storage/emulated/0/Download/sond.webm").delete();
      // log(value.path);

      lst(value,
          File("/storage/emulated/0/Download/${videoName.toUpperCase()}.jpg"));
    });
  }

  void lst(File fileSong, File fileImage) async {
    Directory("/storage/emulated/0/songs/${videoArtist.toUpperCase()}")
        .exists()
        .then((value) async {
      if (value) {
        fileImage.rename(
            "/storage/emulated/0/songs/${videoArtist.toUpperCase()}/${videoName.toUpperCase()}.jpg");
        fileSong
            .rename(
                "/storage/emulated/0/songs/${videoArtist.toUpperCase()}/${videoName.toUpperCase()}.mp3")
            .catchError((error) {
          log(error.toString());
        });
      } else {
        var newDirectory =
            Directory("/storage/emulated/0/songs/${videoArtist.toUpperCase()}")
                .create(recursive: true)
                .then((value) {
          fileImage.rename(
              "/storage/emulated/0/songs/${videoArtist.toUpperCase()}/${videoName.toUpperCase()}.jpg");

          fileSong
              .rename(
                  "/storage/emulated/0/songs/${videoArtist.toUpperCase()}/${videoName.toUpperCase()}.mp3")
              .catchError((error) {
            log(error.toString());
          });
        });
        // log(newDirectory.);
        // ;
      }
      tag(
          path:
              "/storage/emulated/0/songs/${videoArtist.toUpperCase()}/${videoName.toUpperCase()}.mp3",
          imgPath: "./${videoName.toUpperCase()}.jpg");
    });
  }

// /storage/emulated/0/songs/${videoArtist.toUpperCase()}
  Future<void> downloadImage(
      {required String url, required String title}) async {
    await ImageDownloader.downloadImage(url,
        destination: AndroidDestinationType.custom(directory: 'Download')
          ..subDirectory("${title.toUpperCase()}.jpg"));
  }
}
