import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fast_barcode_scanner/fast_barcode_scanner.dart';
import 'package:stacked/stacked.dart';

import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/common/ui.dart';
import 'package:limetrack/enums/scan_mode.dart';
import 'package:limetrack/ui/widgets/lime_app_bar.dart';
import 'package:limetrack/ui/widgets/lime_text.dart';

import 'scan_viewmodel.dart';

class ScanView extends StatelessWidget {
  final ScanMode scanMode;

  const ScanView({super.key, this.scanMode = ScanMode.auto});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ScanViewModel>.reactive(
      onModelReady: (model) => SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        model.initialise();
        model.resumeCamera();
      }),
      disposeViewModel: true,
      builder: (context, model, child) => Scaffold(
        appBar: LimeAppBar(leadingIcon: Icons.arrow_back_ios_new, onLeadingIconTap: model.navigateBack),
        body: BarcodeCamera(
          types: const [BarcodeType.qr],
          resolution: Resolution.hd720,
          framerate: Framerate.fps60,
          mode: DetectionMode.pauseVideo,
          position: CameraPosition.back,
          onScan: (barCode) => model.codeDetected(barCode),
          children: [
            const MaterialPreviewOverlay(
              showSensing: false,
              cutOutBorderColor: Color(0xffa8cf3a),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Column(
                  children: [
                    const Icon(Icons.qr_code, size: 40, color: Colors.white),
                    UI.verticalSpaceExtraSmall,
                    LimeText.body(model.scanQrCodeMessage, color: Colors.white, align: TextAlign.center),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(5.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.flip_camera_android, size: 26, color: Colors.white),
                            onPressed: () async => await model.toggleCameraPosition(),
                          ),
                          UI.horizontalSpaceExtraSmall,
                          IconButton(
                            icon: model.torchState
                                ? const Icon(Icons.flash_on, size: 26, color: Colors.white)
                                : const Icon(Icons.flash_off, size: 26, color: Colors.white),
                            onPressed: () async => await model.toggleTorchState(),
                          ),
                        ],
                      ),
                    ),
                    UI.verticalSpaceMedium,
                    UI.verticalSpaceExtraSmall,
                    LimeText.body('Camera not working? Problems scanning?', color: Colors.white, align: TextAlign.center),
                    UI.verticalSpaceExtraSmall,
                    SizedBox(
                      height: 40,
                      child: OutlinedButton(
                        onPressed: () => model.enterQrCodeManually(),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: kcPrimaryColor),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                        ),
                        child: LimeText.headingFive('TYPE IN CODE', color: kcPrimaryColor),
                      ),
                    ),
                    UI.verticalSpaceMedium,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => ScanViewModel(scanMode: scanMode),
    );
  }
}
