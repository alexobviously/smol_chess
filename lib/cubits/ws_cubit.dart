import 'package:bloc/bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WsCubit extends Cubit<WsState> {
  WsCubit() : super(WsState.initial()) {
    connect();
  }

  WebSocketChannel? chan;

  void connect() {
    chan = WebSocketChannel.connect(Uri.parse('ws://localhost:8080/ws'));
    chan!.stream.listen(_handleEvent);
    emit(WsState(connected: true));
  }

  void closeChannel() {
    chan?.sink.close();
    chan = null;
  }

  void sendMessage(String msg) {
    chan?.sink.add(msg);
  }

  void _handleEvent(dynamic event) {
    print('received $event');
    emit(WsState(connected: true, message: event));
  }
}

class WsState {
  final bool connected;
  final String? message;
  WsState({this.connected = false, this.message});
  factory WsState.initial() => WsState();
}
