import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:drive_music/cubit/youtube_cubit/YoutubeCubit.dart';
import 'package:drive_music/cubit/youtube_cubit/YoutubeStates.dart';
import 'package:drive_music/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YoutubeScreen extends StatelessWidget {
  const YoutubeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<YoutubeCubit, YoutubeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = YoutubeCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.videoResult.isNotEmpty,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    controller: cubit.searchInput,
                    decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 0.2))),
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextButton(
                      onPressed: () {
                        cubit.search();
                      },
                      child: const Text("Search")),
                  const SizedBox(
                    height: 15,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return VideoItem(
                          video: cubit.videoResult[index],
                          context: context,
                          lol: cubit.streams.isNotEmpty);
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: cubit.videoResult.length,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
