import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/common/ui.dart';

import 'startup_viewmodel.dart';

class StartupView extends HookWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final AnimationController animationController = useAnimationController();

    return ViewModelBuilder<StartupViewModel>.reactive(
      onModelReady: (model) => SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        model.runStartupLogic();
      }),
      builder: (context, model, child) => Scaffold(
        backgroundColor: kcPrimaryColor,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: UI.screenHeightPercentage(context, percentage: 0.45),
              color: Colors.white,
              child: null,
            ),
            CustomScrollView(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: UI.screenHeightPercentage(context, percentage: !isLandscape ? 0.40 : 0.35),
                    child: Column(
                      children: [
                        SizedBox(height: UI.screenHeightPercentage(context, percentage: !isLandscape ? 0.06 : 0.02)),
                        Image.asset(
                          'assets/images/limetrack_logo_green-grey.webp',
                          height: UI.screenHeightPercentage(context, percentage: 0.32),
                          scale: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: FractionallySizedBox(
                    widthFactor: 0.85,
                    child: Card(
                      color: const Color(0xffcbe289),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 4.0,
                      child: Align(
                        alignment: Alignment.center,
                        child: Lottie.asset(
                          'assets/animations/qr-code-scanner.json',
                          controller: animationController,
                          repeat: true,
                          onLoaded: (composition) {
                            // set up a status listener so that we know then the animation completes
                            animationController.addStatusListener((status) {
                              if (status == AnimationStatus.completed) {
                                model.indicateAnimationComplete();

                                animationController
                                  ..reset()
                                  ..forward();
                              }
                            });

                            // configure the animation controller with the duration
                            // of the Lottie file, and then start the animations
                            animationController
                              ..duration = composition.duration
                              ..forward();
                          },
                          height: UI.screenHeightPercentage(context, percentage: 0.40),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                //),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      viewModelBuilder: () => StartupViewModel(),
    );
  }
}
