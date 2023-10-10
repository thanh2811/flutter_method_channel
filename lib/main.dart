import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final platform = MethodChannel('NativeChannel');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    platform.setMethodCallHandler((call) => _methodChannelHandler(call));
  }

  void _incrementCounter() async {
    log('invoke method channel');
    var result = await platform
        .invokeMethod("method2")
        .then((value) =>
        showDialog(context: context,
            builder: (context) =>
                AlertDialog(title: Text('receive',),
                    content: Text('result receive: ' + value.toString(),))));
    }

  Future<dynamic> _methodChannelHandler(MethodCall call) async {
    switch (call.method) {
      case "method1":
        log('call method message: ${call.arguments}');
        return Future.value('return value');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Theme
        .of(context)
        .colorScheme
        .inversePrimary, title: Text(widget.title),),
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('You have pushed the button this many times:',),
          Text('$_counter', style: Theme
              .of(context)
              .textTheme
              .headlineMedium,),
        ],),),
      floatingActionButton: FloatingActionButton(onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),),);
  }
}
