import 'dart:math';

import 'package:flutter/material.dart';
import 'package:class2/themes/styles.dart';
// package:class2/ points to our lib folder
import 'package:class2/screens/HomeScreen.dart' as home; //rename the file
import 'package:class2/screens/OctopusScreen.dart' as octo;
import 'package:class2/screens/LobsterScreen.dart' as lobster;

typedef OctopusScreen = octo.Screen;
//create a new class name called OctopusScreen
//point it at the octo file, and the Screen class inside of it
typedef HomeScreen = home.Screen;
typedef LobsterScreen = lobster.Screen;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: MyNav(),
    );
  }
}

class MyNav extends StatefulWidget {
  const MyNav({super.key});

  @override
  State<MyNav> createState() => _MyNavState();
}

class _MyNavState extends State<MyNav> {
  int screenIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: screenIndex, //the state variable
        children: [
          HomeScreen(), //pass data/params/functions through the constructor
          OctopusScreen(),
          LobsterScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.nfc), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.wifi), label: 'Octopus'),
          NavigationDestination(icon: Icon(Icons.usb), label: 'Lobster'),
        ],
        selectedIndex: screenIndex,
        onDestinationSelected: (int index) {
          setState(() {
            screenIndex = index;
          });
        },
      ),
    );
  }
}

class MyPages extends StatefulWidget {
  const MyPages({super.key});

  @override
  State<MyPages> createState() => _MyPagesState();
}

class _MyPagesState extends State<MyPages> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  void _updatePage(int index) {
    if (index > 2) return;
    //error handling
    _controller.animateToPage(
      index,
      duration: Duration(milliseconds: 400),
      curve: Curves.bounceInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _controller,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Page One'),
                TextButton(onPressed: () => _updatePage(1), child: Text('go to 2')),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Page Two'),
                TextButton(onPressed: () => _updatePage(2), child: Text('go to 3')),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Page Three'),
                TextButton(onPressed: () => _updatePage(0), child: Text('go to 1')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyDialogs extends StatefulWidget {
  const MyDialogs({super.key});

  @override
  State<MyDialogs> createState() => _MyDialogsState();
}

class _MyDialogsState extends State<MyDialogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(width: double.infinity),
          OutlinedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  // AlertDialog(title: , content: , actions: [])
                  return Dialog.fullscreen(
                    child: Column(
                      children: [
                        Text('Full screen dialog'),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'You betcha.'); //to close the dialog
                          },
                          child: Text('close'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Text('Full Screen'),
          ),
          OutlinedButton(onPressed: () {}, child: Text('Alert Dialog')),
        ],
      ),
    );
  }
}

class MyStack extends StatefulWidget {
  const MyStack({super.key});

  @override
  State<MyStack> createState() => _MyStackState();
}

class _MyStackState extends State<MyStack> {
  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  void changeColor(Color c) {
    setState(() {
      clr = c;
    });
  }

  Color clr = Colors.blue;
  bool yep = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('MyStack'),
          MyWidget(clr: clr),
          OtherWidget(func: changeColor),
        ],
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  MyWidget({super.key, required this.clr});

  Color clr;

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int randomStateNumber = 123;

  @override
  void initState() {
    super.initState();
    randomStateNumber = Random().nextInt(1000);
    //happens before anything is rendered on the screen
  }

  @override
  void dispose() {
    // this runs when the element is removed from the element tree
    super.dispose();
    //think clean up when you navigate away from this screen
  }

  void remi(int newVal) {
    setState(() {
      randomStateNumber = newVal;
      //when this function finishes BUILD gets called
    });
    //TextButton(onPressed: () => remi(5), child: Text('click'))
  }

  @override
  Widget build(BuildContext context) {
    return Placeholder(color: widget.clr);
  }
}

class OtherWidget extends StatefulWidget {
  OtherWidget({super.key, required this.func});

  Function func;

  @override
  State<OtherWidget> createState() => _OtherWidgetState();
}

class _OtherWidgetState extends State<OtherWidget> {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        widget.func(Colors.purpleAccent);
      },
      child: Text('Change Color'),
    );
  }
}
