import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

part 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  final Connectivity _connectivity;
  final InternetConnection _internetChecker;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  NetworkCubit({
    required Connectivity connectivity,
    required InternetConnection internetChecker,
  }) : _connectivity = connectivity,
       _internetChecker = internetChecker,
       super(const NetworkState.initial()) {
    _init();
  }

  static NetworkCubit get(BuildContext context) => context.read<NetworkCubit>();

  Future<void> _init() async {
    await _checkInternet();
    _subscription = _connectivity.onConnectivityChanged.listen((_) async {
      await _checkInternet();
    });
  }

  Future<void> checkConnectivity() => _checkInternet();

  Future<void> _checkInternet() async {
    final hasInternet = await _internetChecker.hasInternetAccess;
    emit(
      hasInternet
          ? const NetworkState.connected()
          : const NetworkState.disconnected(),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
