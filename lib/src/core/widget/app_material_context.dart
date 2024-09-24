import 'package:flutter/material.dart';

import '../../feature/main/view/pages/home_page.dart';
import '../../feature/settings/inherited_locale_notifier.dart';
import '../../feature/settings/inherited_remote_notifier.dart';
import '../../feature/settings/inherited_theme_notifier.dart';
import '../../feature/settings/locale_controller.dart';
import '../../feature/settings/remote_controller.dart';
import '../../feature/settings/theme_controller.dart';

final ThemeController themeController = ThemeController();
final LocalController localController = LocalController();
final RemoteController remoteController = RemoteController();

class AppMaterialContext extends StatelessWidget {
  const AppMaterialContext({super.key});

  @override
  Widget build(BuildContext context) {
    return InheritedRemoteNotifier(
      remoteController: remoteController,
      child: InheritedThemeNotifier(
        themeController: themeController,
        child: InheritedLocalNotifier(
          localController: localController,
          child: Builder(builder: (context) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: InheritedThemeNotifier.maybeOf(context)?.theme,
              locale: InheritedLocalNotifier.maybeOf(context)?.appLocal,
              home: Builder(
                builder: (_) {
                  if (InheritedRemoteNotifier.maybeOf(_)!.isBlocked) {
                    return const BlockPage();
                  } else {
                    return const HomePage();
                  }
                },
              ),
              // home:
            );
          }),
        ),
      ),
    );
  }
}

class BlockPage extends StatelessWidget {
  const BlockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Text(
          "You are blocked",
          style: TextStyle(
            color: Colors.yellow,
            fontSize: 32,
          ),
        ),
      ),
    );
  }
}
