import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:drive_music/cubit/cubit.dart';
import 'package:drive_music/cubit/states.dart';
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
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: cubit.linkEntry,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(cubit.videoName),
                  const SizedBox(
                    height: 10,
                  ),
                  ConditionalBuilder(
                    condition: cubit.imageUrl != '',
                    builder: (context) {
                      return CachedNetworkImage(
                        imageUrl: cubit.imageUrl,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                      );
                    },
                    fallback: (context) {
                      return const SizedBox();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      cubit.downloadVideo(link: cubit.linkEntry.text);
                    },
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                    child: const Text(
                      "Process",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ConditionalBuilder(
                    condition: (cubit.progress != 0 && cubit.progress != 100),
                    fallback: (context) => ConditionalBuilder(
                      condition: cubit.progress == 100,
                      builder: (context) {
                        return const Text("Downloaded Successfully");
                      },
                      fallback: (context) => const SizedBox(),
                    ),
                    builder: (context) => LinearPercentIndicator(
                      center: Text("${cubit.progress.toString()}%"),
                      animationDuration: 2500,
                      progressColor: Colors.lightBlue[400],
                      percent: cubit.progress / 100,
                      lineHeight: 15.0,
                      barRadius: const Radius.circular(8),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
