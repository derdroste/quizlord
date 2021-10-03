import 'package:flutter/material.dart';
import 'package:quiz_lord/components/matchmaking_loading_dialog.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/status.dart' as status;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<HomeScreen> {
  late WebSocketChannel _channel;
  bool _loading = false;
  bool _connected = false;

  @override
  void initState() {
    _startChannelConnection();
    super.initState();
  }

  void _startChannelConnection() {
    if (!_connected) {
      _channel = WebSocketChannel.connect(
        Uri.parse('ws://quizlord-22rsv.ondigitalocean.app/:3000/'),
      );
      _connected = true;
      print('Channel connection started');
    }
  }

  void _closeChannelConnection() {
    _channel.sink.close();
    print('Channel connection closed');
    _connected = false;
  }

  void _dismissMatchmakingDialog() {
    _closeChannelConnection();
  }

  void _startMatchmaking() {
    _startChannelConnection();
    _channel.sink.add('Hello from Flutter!');
    setState(() {
      //  _loading = true;
    });
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return MatchmakingLoadingDialog(onClose: _dismissMatchmakingDialog);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: _startMatchmaking,
                  child: const Text('Playbuddne'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                ),
              ),
            ),
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                return Text(snapshot.hasData ? '${snapshot.data}' : '');
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _closeChannelConnection();
    super.dispose();
  }
}
