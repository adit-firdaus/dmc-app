import 'package:dmc/pages/ads_splash_screen.dart';
import 'package:dmc/pages/home_page.dart';
import 'package:dmc/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DMC',
      theme: darkTheme(),
      home: const AdsSplashScreenPage(
        imageUrl:
            'https://2.bp.blogspot.com/-WHXfT6kLk8c/XHtzFKEx05I/AAAAAAAAIt0/fSGwUV8R2eQRWfzG1QJXkhnlHVmhh_epwCLcBGAs/s1600/BROSUR%2BKECIL.jpg',
        duration: Duration(seconds: 7),
        nextPage: LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              'assets/icon/icon.png',
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              'Watch TV shows & movies. Anywhere. Anytime.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 40),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Username',
                fillColor: Colors.white24,
                filled: true,
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Password',
                fillColor: Colors.white24,
                filled: true,
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Forgot password?',
                style: TextStyle(color: Colors.white54),
              ),
            ),
            const SizedBox(height: 20),
            ZoomTapAnimation(
              child: TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orange,
                ),
                icon: const Icon(Icons.login),
                label: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
