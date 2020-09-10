import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

void callWaiter() {
  final String baseUrl =
      'https://nulve-node-api.herokuapp.com/api/v1/request_waiter';
  final channel = IOWebSocketChannel.connect(baseUrl);

  channel.stream.listen((message) {
    channel.sink.add({'id': '5f07e5b364e680e03b9fc676'});
    print(message);
    channel.sink.close(status.goingAway);
  });
}
