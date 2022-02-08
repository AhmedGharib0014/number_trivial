import 'dart:io';

abstract class NetWorkInfo {
  Future<bool>? get isConnected;
}

class NetworkInfoImple extends NetWorkInfo {
  @override
  Future<bool>? get isConnected async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else
        return false;
    } on SocketException catch (_) {
      return false;
    } catch (_) {
      return false;
    }
  }
}
