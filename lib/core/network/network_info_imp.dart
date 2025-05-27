
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:my_task_products/core/network/network_info.dart';

class NetworkInfoImp extends NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImp({required this.connectivity});

  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    return result.first != ConnectivityResult.none;
  }
}
