import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:handballthegame/interface/screens/game_screen.dart';
import 'package:handballthegame/interface/screens/main_screen.dart';

void main() {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/game',
        builder: (context, state) => const GameScreen(),
      ),
    ],
  );

  runApp(MaterialApp.router(
    routerConfig: router,
  ));
}
