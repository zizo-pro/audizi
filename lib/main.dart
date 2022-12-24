import 'package:drive_music/cubit/downloader_cubit/DownloaderStates.dart';
import 'package:drive_music/cubit/main_cubit/AppCubit.dart';
import 'package:drive_music/cubit/main_cubit/AppStates.dart';
import 'package:drive_music/cubit/youtube_cubit/YoutubeCubit.dart';
import 'package:drive_music/screens/layout/home_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/downloader_cubit/DownloaderCubit.dart';

void main() {
  print("test");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(create: (context) => DownloaderCubit()),
        BlocProvider(create: (context) => YoutubeCubit()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return const MaterialApp(
              home: HomeLayout(),
            );
          }),
    );
  }
}
