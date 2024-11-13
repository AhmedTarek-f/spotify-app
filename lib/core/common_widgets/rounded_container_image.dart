import 'package:flutter/material.dart';

class RoundedContainerImage extends StatelessWidget {
  const RoundedContainerImage({super.key, required this.image, this.fit = BoxFit.contain,this.onTap});
  final String image;
  final BoxFit fit;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width*0.2,
      height: MediaQuery.sizeOf(context).height*0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            image,
            fit: fit,
          ),
        ),
      ),
    );
  }
}
