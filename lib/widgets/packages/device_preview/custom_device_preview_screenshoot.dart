import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDevicePreviewScreenshot extends StatefulWidget {
  const CustomDevicePreviewScreenshot({
    super.key,
    this.onScreenshot = screenshotAsBase64,
    this.multipleScreenshots = false,
  });

  final ScreenshotProcessor onScreenshot;

  /// If enabled, a new item is added to the menu which allwo screenshots to be
  /// taken for all available device.
  ///
  /// Make sure to have an adapted [onScreenshot] processor for this ([screenshotAsBase64] won't
  /// be really useful in this case).
  final bool multipleScreenshots;

  @override
  State<CustomDevicePreviewScreenshot> createState() =>
      _CustomDevicePreviewScreenshotState();
}

class _CustomDevicePreviewScreenshotState
    extends State<CustomDevicePreviewScreenshot> {
  bool _isLoading = false;

  void screenshoot() async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (!mounted) return;

      final result = await DevicePreview.screenshot(context);

      if (!mounted) return;

      await widget.onScreenshot(
        context,
        result,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void multipleScreenshoot() async {
    setState(() {
      _isLoading = true;
    });
    try {
      DevicePreviewStore store = context.read<DevicePreviewStore>();

      final initialDevice = store.deviceInfo;

      if (!mounted) return;

      var devices = DevicePreview.availableDeviceIdentifiers(context);

      if (!mounted) return;

      for (var device in devices) {
        if (!mounted) return;

        DevicePreview.selectDevice(
          context,
          device,
        );

        await Future.delayed(const Duration(milliseconds: 500));

        if (!mounted) return;

        final result = await DevicePreview.screenshot(context);

        if (!mounted) return;

        await widget.onScreenshot(context, result);
      }

      if (!mounted) return;

      DevicePreview.selectDevice(
        context,
        initialDevice.identifier,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ToolPanelSection(
      title: 'Screenshot',
      children: [
        ListTile(
            key: const Key('single-screenshot'),
            title: const Text('Take a screenshot'),
            subtitle: const Text('Currently selected device'),
            trailing: _isLoading ? const CircularProgressIndicator() : null,
            onTap: _isLoading ? null : screenshoot),
        if (widget.multipleScreenshots)
          ListTile(
            key: const Key('muliple-screenshot'),
            title: const Text('Take multiple screenshots'),
            subtitle: const Text('All available devices'),
            trailing: _isLoading ? const CircularProgressIndicator() : null,
            onTap: _isLoading ? null : multipleScreenshoot,
          ),
      ],
    );
  }
}
