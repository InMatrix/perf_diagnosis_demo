import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class ChannelDemo extends StatefulWidget {
  @override
  _ChannelDemoState createState() => _ChannelDemoState();
}

class _ChannelDemoState extends State<ChannelDemo> {
  BasicMessageChannel<String> _channel;
  String _response;

  @override
  void initState() {
    super.initState();
    _response = 'No response yet...';
    _channel = BasicMessageChannel<String>('shuttle', const StringCodec());
    _channel.setMessageHandler((String response) {
      setState(() => _response = response);
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Channel Demo"),
      ),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(_response),
        ],
      ),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.mail),
        onPressed: () async => print(await _channel.send('Message from Dart'))
      ),
    );
  }
}
