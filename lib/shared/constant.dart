import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:drive_music/cubit/downloader_cubit/DownloaderCubit.dart';
import 'package:drive_music/cubit/youtube_cubit/YoutubeCubit.dart';
import 'package:drive_music/cubit/youtube_cubit/YoutubeStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_api/youtube_api.dart';

Color? greyTextColor = Colors.grey[500];
List<Widget> test = [
  Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(border: Border.all(width: 0.4)),
  ),
  Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(border: Border.all(width: 0.4)),
  ),
  Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(border: Border.all(width: 0.4)),
  ),
  Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(border: Border.all(width: 0.4)),
  ),
  Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(border: Border.all(width: 0.4)),
  ),
  Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(border: Border.all(width: 0.4)),
  ),
  Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(border: Border.all(width: 0.4)),
  ),
  Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(border: Border.all(width: 0.4)),
  ),
  Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(border: Border.all(width: 0.4)),
  ),
  Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(border: Border.all(width: 0.4)),
  )
];

Widget VideoItem(
    {required YouTubeVideo video,
    required BuildContext context,
    required bool lol}) {
  var cubit = YoutubeCubit.get(context);
  return BlocConsumer<YoutubeCubit, YoutubeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: 80,
          // decoration: BoxDecoration(
          //     border: Border.all(
          //   width: 0.2,
          //   color: Colors.grey[300] as Color,
          // )),
          child: Row(
            children: [
              Image.network(
                video.thumbnail.medium.url as String,
                width: 140,
                height: 1500,
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(video.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        strutStyle: const StrutStyle(forceStrutHeight: true),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),
                    // const SizedBox(height: 5),
                    const Spacer(),
                    Text(
                      video.channelTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: greyTextColor,
                        fontSize: 12,
                      ),
                    ),
                    // const SizedBox(height: 2),
                    Container(
                      height: 24,
                      child: Row(
                        children: [
                          Text(
                            video.duration as String,
                            style:
                                TextStyle(color: greyTextColor, fontSize: 12),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () async{
                                await DownloaderCubit.get(context).downloadVideo(link: video.url);
                                // await cubit.getDownloadDetails(link: video.url);
                                // showDialog(
                                //     context: context,
                                //     builder: (context) {
                                //       return AlertDialog(
                                //         content: Container(
                                //           height: 300,
                                //           child: SingleChildScrollView(
                                //             child: Column(
                                //               children: [
                                //                 Text("Download Quality"),
                                //                 const SizedBox(
                                //                   height: 15,
                                //                 ),
                                //                 GridView.count(
                                //                   physics:
                                //                       const NeverScrollableScrollPhysics(),
                                //                   mainAxisSpacing: 5.0,
                                //                   crossAxisSpacing: 5.0,
                                //                   shrinkWrap: true,
                                //                   crossAxisCount: 3,
                                //                   children: cubit.streamItem,
                                //                 )
                                //               ],
                                //             ),
                                //           ),
                                //         ),
                                //       );
                                //     });
                              },
                              icon: const Icon(
                                Icons.download,
                                color: Colors.white,
                                size: 12,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      });
}

List<Widget> streamItem = [];
void downloadItem() {
  streamItem.add(
    Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(border: Border.all(width: 0.4))),
  );
}
