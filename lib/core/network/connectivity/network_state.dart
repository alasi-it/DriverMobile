part of 'network_cubit.dart';

enum NetworkStatus { initial, connected, disconnected }

class NetworkState {
  final NetworkStatus status;

  const NetworkState._(this.status);

  const NetworkState.initial() : this._(NetworkStatus.initial);
  const NetworkState.connected() : this._(NetworkStatus.connected);
  const NetworkState.disconnected() : this._(NetworkStatus.disconnected);

  bool get isConnected => status == NetworkStatus.connected;
  bool get isDisconnected => status == NetworkStatus.disconnected;
}
