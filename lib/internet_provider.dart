import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/config/app_routes.dart';
import 'main.dart';

class InternetProvider extends ChangeNotifier {
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity connectivity = Connectivity();
  BuildContext? currentContext;
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  InternetProvider() {
    initConnectivity();
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }

    return updateConnectionStatus(result);
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    connectionStatus = result;
    print('212121 changed $result');
    if (connectionStatus == ConnectivityResult.none) {
      currentContext = navigatorKey.currentState?.context;
      if (currentContext != null) {
        Navigator.pushNamed(currentContext!, AppRoutes.noInternetScreen);
      }
    } else {
      if (currentContext != null && Navigator.canPop(currentContext!)) {
        Navigator.pop(currentContext!);
        currentContext = null;
      }
    }
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    connectivitySubscription.cancel();
  }
}
