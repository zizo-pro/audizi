import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:drive_music/cubit/downloader_cubit/DownloaderCubit.dart';
import 'package:drive_music/cubit/downloader_cubit/DownloaderStates.dart';
import 'package:drive_music/cubit/main_cubit/AppCubit.dart';
import 'package:drive_music/cubit/main_cubit/AppStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 23, 23, 23),
            appBar: cubit.appBars[cubit.currentIndex],
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (value) {
                  cubit.changeBottomNav(value);
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.video_label_outlined), label: "Youtube"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.download), label: "Download")
                ]),
          );
        });
  }
}
