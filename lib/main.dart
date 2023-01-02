import 'package:drive_music/cubit/bloc_observer.dart';
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
  BlocOverrides.runZoned(() {
    runApp(const MyApp());
  }, blocObserver: MyBlocObserver());
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
        BlocProvider(create: (context) => YoutubeCubit()..getTrend()),
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
