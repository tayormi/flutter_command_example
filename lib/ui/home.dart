import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_command_example/models/joke_dto.dart';
import 'package:flutter_command_example/viewmodels/home_vm.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final homeVm = HomeViewModel();
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Jokes😂'),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => homeVm.getJokeCommand.execute("history"))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Choose a category'),
            ValueListenableBuilder<List<String>>(
                valueListenable: homeVm.getJokeCategories,
                builder: (BuildContext context, List<String> categories, _) {
                  return new DropdownButton<String>(
                    items: categories.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    // value: "Select",
                    onChanged: (value) => homeVm.getJokeCommand.execute(value),
                  );
                }),
            SizedBox(
              height: 40,
            ),
            CommandBuilder<String, JokeDto>(
              command: homeVm.getJokeCommand,
              whileExecuting: (context, joke, _) => Center(
                child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: CircularProgressIndicator(),
                ),
              ),
              onData: (context, joke, _) => Column(
                children: [
                  Image.network(
                    joke.iconUrl,
                    height: 100,
                    width: 100,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.error,
                      size: 40,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    '${joke.value}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
              onError: (context, error, category, _) => Column(
                children: [
                  Text('An Error has occurred!'),
                  Text(error.toString()),
                ],
              ),
            )
            // ValueListenableBuilder<bool>(
            //   valueListenable: homeVm.getJokeCommand.isExecuting,
            //   builder: (BuildContext context, bool isRunning, _) {
            //     if (isRunning == true) {
            //       return Center(
            //         child: Container(
            //           width: 50.0,
            //           height: 50.0,
            //           child: CircularProgressIndicator(),
            //         ),
            //       );
            //     } else {
            //       return ValueListenableBuilder<JokeDto>(
            //           valueListenable: homeVm.getJokeCommand,
            //           builder: (BuildContext context, JokeDto joke, _) {
            //             return Column(
            //               children: [
            //                 Image.network(
            //                   joke.iconUrl,
            //                   height: 100,
            //                   width: 100,
            //                   errorBuilder: (context, error, stackTrace) =>
            //                       Icon(
            //                     Icons.error,
            //                     size: 40,
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   height: 40,
            //                 ),
            //                 Text(
            //                   '${joke.value}',
            //                   textAlign: TextAlign.center,
            //                   style: TextStyle(fontSize: 25),
            //                 ),
            //               ],
            //             );
            //           });
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
