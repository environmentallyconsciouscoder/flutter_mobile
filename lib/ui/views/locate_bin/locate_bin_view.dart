import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:stacked/stacked.dart';

import 'locate_bin_viewmodel.dart';

class LocateBinView extends StatelessWidget {
  const LocateBinView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LocateBinViewModel>.reactive(
      onModelReady: (model) => SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        model.runStartupLogic();
      }),
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text('Locate')),
          body: Container(
            child: null,
          ),
        ),
      ),
      viewModelBuilder: () => LocateBinViewModel(),
    );
  }
}
