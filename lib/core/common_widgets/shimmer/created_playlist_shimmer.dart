import 'package:flutter/material.dart';
import 'package:spotify/core/common_widgets/shimmer/shimmer_effect.dart';

class CreatedPlaylistShimmer extends StatelessWidget {
  const CreatedPlaylistShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                color: Colors.blueGrey,
                spreadRadius: 1,
                blurRadius:  1,
                blurStyle: BlurStyle.outer
            )
          ]
      ),
      child:Container(
        decoration: BoxDecoration(
            borderRadius:  BorderRadius.circular(12)
        ),
        child: const Row(
          children: [
            ShimmerEffect(width: 55, height: 55 ,radius: 55,),
            SizedBox(width: 12,),
            ShimmerEffect(width: 80, height: 12),
          ],
        ),
      ),
    );
  }
}
