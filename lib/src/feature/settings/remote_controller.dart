import 'dart:async';
import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';

class RemoteController with ChangeNotifier {
  /// firebase object
  static final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  /// initial value for _isBlocked Constructor
  RemoteController() : _isBlocked = false {
    fetchAndActivate();
  }

  Future<void> fetchAndActivate() async {
    _remoteConfig.setDefaults({
      "block": _isBlocked,
    });

    await _remoteConfig.fetchAndActivate();

    _isBlocked = _remoteConfig.getBool("block");
    notifyListeners();

    _remoteConfig.onConfigUpdated.listen((data) async {
      await activate();
      notifyListeners();
    });
  }

  Future<void> activate() async {
    await _remoteConfig.fetchAndActivate();
    _isBlocked = _remoteConfig.getBool("block");
    log(isBlocked.toString());
    notifyListeners();
  }

  bool _isBlocked;

  bool get isBlocked => _isBlocked;
}