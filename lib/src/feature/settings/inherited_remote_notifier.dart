import 'package:flutter/widgets.dart';

import 'remote_controller.dart';

@immutable
class InheritedRemoteNotifier extends InheritedNotifier<RemoteController> {
  const InheritedRemoteNotifier({
    required final RemoteController remoteController,
    required super.child,
    super.key,
  }) : super(
          notifier: remoteController,
        );

  static RemoteController? maybeOf(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context
          .dependOnInheritedWidgetOfExactType<InheritedRemoteNotifier>()
          ?.notifier;
    } else {
      final inhW = context
          .getElementForInheritedWidgetOfExactType<InheritedRemoteNotifier>()
          ?.widget;
      return inhW is InheritedRemoteNotifier ? inhW.notifier : null;
    }
  }
}
