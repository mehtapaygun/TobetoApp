import 'package:flutter/material.dart';
import 'package:tobeto_app/config/constant/theme/image.dart';
import 'package:tobeto_app/models/course_model.dart';
import 'package:tobeto_app/config/constant/core/widget/lottie_button.dart';
import 'package:tobeto_app/pages/course/video_player.dart';

class CourseImage extends StatelessWidget {
  const CourseImage({Key? key, required this.course}) : super(key: key);

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // CustomVideoPlayer(videoLink: course.videoLink!),
        Container(
          child: CustomVideoPlayer(
            videoLink: course.videoLink!,
          ),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  blurRadius: 10, color: Color.fromARGB(255, 251, 251, 251))
            ],
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
        Positioned(
            top: 30,
            left: 10,
            child: IconButton(
                onPressed: () => Navigator.of(context).pushNamed("/viewmore"),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 30,
                ))),
        const Positioned(
            bottom: 0,
            left: 30,
            child: LottieButton(
              url: AppImage.lottieSave,
            )),
        const Positioned(
          bottom: 0,
          right: 30,
          child: LottieButton(
            url: AppImage.lottieFavourite,
          ),
        ),
      ],
    );
  }
}
