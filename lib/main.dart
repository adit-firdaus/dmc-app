import 'package:dmc/app.dart';
import 'package:dmc/widgets/packages/device_preview/custom_device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Necessary initialization for package:media_kit.
  MediaKit.ensureInitialized();
  runApp(
    const CustomDevicePreview(
      enabled: !kReleaseMode,
      child: MyApp(),
    ),
  );
}
