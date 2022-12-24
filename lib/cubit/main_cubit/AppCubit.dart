import 'dart:developer';

import 'package:drive_music/cubit/main_cubit/AppStates.dart';
import 'package:drive_music/cubit/youtube_cubit/YoutubeCubit.dart';
import 'package:drive_music/cubit/youtube_cubit/YoutubeStates.dart';
import 'package:drive_music/screens/downloader_screen/downloader_screen.dart';
import 'package:drive_music/screens/youtube_screen/youtube_screen.dart';
import 'package:drive_music/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_api/youtube_api.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());
  static AppCubit get(context) => BlocProvider.of(context);
  // TextEditingController searchInput = TextEditingController();
  List<Widget> screens = const [YoutubeScreen(), DownloaderScreen()];
  int currentIndex = 0;

  List<AppBar> appBars = [AppBar(), AppBar()];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }

  // Widget appbar() {
  //   return AppBar(
  //     actions: [
  //       Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Container(
  //           width: 250,
  //           height: 10,
  //           decoration: BoxDecoration(
  //               color: Colors.white,
  //               border: Border.all(color: Colors.blue),
  //               borderRadius: const BorderRadius.all(Radius.circular(20))),
  //           child: Padding(
  //             padding: const EdgeInsets.only(bottom: 0, left: 10, top: 20),
  //             child: TextFormField(
  //               controller: searchInput,
  //               decoration: InputDecoration(
  //                   border: InputBorder.none, hintText: "Search ..."),
  //             ),
  //           ),
  //         ),
  //       ),
  //       const SizedBox(width: 30),
  //       IconButton(
  //           onPressed: () {
  //             search();
  //           },
  //           icon: Icon(Icons.search))
  //     ],
  //   );
  // }

  
}
