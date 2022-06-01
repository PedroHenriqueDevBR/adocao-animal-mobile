import 'package:adocao_local/src/shares/core/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AvatarContainerWidget extends StatelessWidget {
  const AvatarContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      padding: const EdgeInsets.only(
        top: 100,
        bottom: 75,
      ),
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          child: RiveAnimation.asset(
            AppAnimations.avatarAnimation,
            animations: const ['idlePreview'],
            antialiasing: true,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary,
              width: 5.0,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(100),
            ),
          ),
        ),
      ),
    );
  }
}
