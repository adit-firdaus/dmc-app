import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

class AdsSplashScreenPage extends StatefulWidget {
  final String imageUrl;
  final Duration duration;
  final Widget nextPage;

  const AdsSplashScreenPage({
    super.key,
    required this.imageUrl,
    required this.duration,
    required this.nextPage,
  });

  @override
  State<AdsSplashScreenPage> createState() => _AdsSplashScreenPageState();
}

class _AdsSplashScreenPageState extends State<AdsSplashScreenPage> {
  late Timer _timer;
  final _remainingMilliseconds = 0.obs;
  final _isImageLoaded = false.obs;

  @override
  void initState() {
    super.initState();
    _remainingMilliseconds.value = widget.duration.inMilliseconds;
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_remainingMilliseconds > 0) {
        _remainingMilliseconds.value -= 100;
      } else {
        _navigateToNextPage();
      }
    });
  }

  void _navigateToNextPage() {
    _timer.cancel();
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (_) => widget.nextPage,
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: CachedNetworkImage(
                imageUrl: widget.imageUrl,
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageBuilder: (context, imageProvider) {
                  // Check if the image is loaded and start countdown only once
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (!_isImageLoaded.value) {
                      _isImageLoaded.value = true;
                      _startCountdown();
                    }
                  });

                  return Image(image: imageProvider);
                },
              ),
            ),
            Obx(() {
              if (_isImageLoaded.value) {
                return Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: LinearProgressIndicator(
                    value: 1.0 -
                        (_remainingMilliseconds.value /
                            widget.duration.inMilliseconds),
                    backgroundColor: Colors.grey,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.orange),
                  ),
                );
              } else {
                return Container();
              }
            }),
          ],
        ),
      ),
    );
  }
}
