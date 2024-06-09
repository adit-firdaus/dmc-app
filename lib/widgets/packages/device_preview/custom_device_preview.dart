// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'dart:io';

import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:flutter/material.dart';
import 'package:dmc/widgets/packages/device_preview/custom_device_preview_screenshoot.dart';

class CustomDevicePreview extends StatefulWidget {
  const CustomDevicePreview({
    this.enabled = true,
    super.key,
    required this.child,
  });

  final bool enabled;
  final Widget child;

  @override
  State<CustomDevicePreview> createState() => _CustomDevicePreviewState();
}

class _CustomDevicePreviewState extends State<CustomDevicePreview> {
  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: widget.enabled,
      devices: devices,
      tools: [
        ...DevicePreview.defaultTools,
        CustomDevicePreviewScreenshot(
          multipleScreenshots: true,
          onScreenshot: (context, screenshot) async {
            DeviceInfo device = screenshot.device;

            String stringPath =
                '${Directory.current.path}\\.device_preview\\${device.name}';

            Directory(stringPath).createSync(recursive: true);

            final file = File(
              '$stringPath\\${DateTime.now().toIso8601String().replaceAll(':', '-')}.png',
            );

            log('Screenshot taken: ${file.path}');

            await file.writeAsBytes(screenshot.bytes);

            return;
          },
        ),
      ],
      builder: (context) => widget.child,
    );
  }
}

List<DeviceInfo> devices = [
  i_iphone_8_plus,
  i_iphone_12_pro_max,
  i_ipad_pro,
];

DeviceInfo i_iphone_12_pro_max = DeviceInfo.genericPhone(
  id: 'iphone-12-pro-max',
  platform: TargetPlatform.iOS,
  name: 'iPhone 12 Pro Max',
  pixelRatio: 3.0,
  screenSize: const Size(428.0, 926.0),
  safeAreas: const EdgeInsets.only(
    left: 0.0,
    top: 20.0,
    right: 0.0,
    bottom: 0.0,
  ),
  rotatedSafeAreas: const EdgeInsets.only(
    left: 44.0,
    top: 0.0,
    right: 44.0,
    bottom: 21.0,
  ),
  framePainter: const GenericPhoneFramePainter(
    screenRadius: Radius.circular(0),
  ),
);

DeviceInfo i_iphone_8_plus = DeviceInfo.genericPhone(
  id: 'iphone-8-plus',
  platform: TargetPlatform.iOS,
  name: 'iPhone 8 Plus',
  pixelRatio: 3.0,
  screenSize: const Size(414.0, 736.0),
  safeAreas: const EdgeInsets.only(
    left: 0.0,
    top: 20.0,
    right: 0.0,
    bottom: 0.0,
  ),
  rotatedSafeAreas: const EdgeInsets.only(
    left: 20.0,
    top: 0.0,
    right: 0.0,
    bottom: 0.0,
  ),
  framePainter: const GenericPhoneFramePainter(
    screenRadius: Radius.circular(0),
  ),
);

DeviceInfo i_ipad_pro = DeviceInfo.genericTablet(
  id: 'ipad-pro',
  platform: TargetPlatform.iOS,
  name: 'iPad Pro',
  pixelRatio: 2.0,
  screenSize: const Size(1024.0, 1366.0),
  safeAreas: const EdgeInsets.only(
    left: 0.0,
    top: 20.0,
    right: 0.0,
    bottom: 0.0,
  ),
  rotatedSafeAreas: const EdgeInsets.only(
    left: 20.0,
    top: 0.0,
    right: 0.0,
    bottom: 0.0,
  ),
  framePainter: const GenericTabletFramePainter(
    screenRadius: Radius.circular(0),
  ),
);
