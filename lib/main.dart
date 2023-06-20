import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Register the background task
  await Workmanager().initialize(callbackDispatcher,isInDebugMode: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: ()async {
          var unique = DateTime.now().second;
          await Workmanager().registerOneOffTask(unique.toString(), taskName,inputData: {"key":"vamsi reddy"});
        },child: Text("Schedule"),),
      ),
    );
  }
}

const taskName = "firstTask";
void callbackDispatcher()
{
  // Create a separate isolate for the background task
  // Spawn a separate isolate for the background task
  Isolate.spawn(backgroundTask, null);
}

void backgroundTask(dynamic _) {
  // Background task execution logic goes here
  // This code runs in a separate isolate
  Workmanager().executeTask((taskName, inputData) {
    // Task execution logic
    switch(taskName)
    {
      case "firstTask":
        print("Something something");
        Fluttertoast.showToast(msg: "task is working");
        break;
      default:
    }
    return Future.value(true);
  });
}

