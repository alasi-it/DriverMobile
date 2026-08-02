import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Future<bool> get hasInternet;
  Future<List<ConnectivityResult>> get connectivityType;
  Future<bool> get isConnectedToWiFi;
  Future<bool> get isConnectedToMobile;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;
  final InternetConnection internetChecker;

  NetworkInfoImpl({required this.connectivity, required this.internetChecker});

  @override
  Future<bool> get isConnected async {
    final results = await connectivity.checkConnectivity();
    return results.any(
      (r) =>
          r == ConnectivityResult.wifi ||
          r == ConnectivityResult.mobile ||
          r == ConnectivityResult.ethernet,
    );
  }

  @override
  Future<bool> get hasInternet async {
    return await internetChecker.hasInternetAccess;
  }

  @override
  Future<List<ConnectivityResult>> get connectivityType async {
    final results = await connectivity.checkConnectivity();
    return results.isEmpty ? [ConnectivityResult.none] : results;
  }

  @override
  Future<bool> get isConnectedToWiFi async {
    final results = await connectivity.checkConnectivity();
    return results.any((r) => r == ConnectivityResult.wifi);
  }

  @override
  Future<bool> get isConnectedToMobile async {
    final results = await connectivity.checkConnectivity();
    return results.any((r) => r == ConnectivityResult.mobile);
  }
}
