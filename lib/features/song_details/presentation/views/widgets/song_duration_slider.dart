import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/features/song_details/presentation/views_model/song_details_controller.dart';

class SongDurationSlider extends StatelessWidget {
  const SongDurationSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final controller = SongDetailsController.instance;
    return  Column(
      children: [
        Obx(
              ()=> Slider(
              min: 0.0,
              max: controller.duration.value.inSeconds.toDouble(),
              value: controller.position.value.inSeconds.toDouble(),
              inactiveColor: isDarkMode? const Color(0xff888888) : const Color(0xff000000),
              activeColor: isDarkMode? const Color(0xffB7B7B7) : const Color(0xff434343),
              onChanged: controller.handleSeek
          ),
        ),
        Obx(
              ()=> Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(controller.formatDuration(controller.position.value)),
              Text(controller.formatDuration(controller.duration.value)),
            ],
          ),
        ),
      ],
    );
  }
}
