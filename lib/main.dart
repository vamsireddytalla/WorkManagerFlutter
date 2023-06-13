import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
          await Workmanager().registerPeriodicTask(unique.toString(), taskName,initialDelay: Duration(seconds: 30));
        },child: Text("Schedule"),),
      ),
    );
  }
}

const taskName = "firstTask";
void callbackDispatcher()
{
  Workmanager().executeTask((taskName, inputData) {
    switch(taskName)
    {
      case "firstTask":
        print("Something something");
        break;
      default:
    }
    return Future.value(true);
  });
}

