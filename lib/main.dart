import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:http/http.dart' as http;
// import 'package:universal_html/html.dart' as html;
// import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

final myStack = Stack<String>();

class Stack<E> {
  final _list = <E>[];
  void push(E value) => _list.add(value);

  E pop() => _list.removeLast();
  E get peek => _list.last;

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();
}

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    ),
  );
}

// class MyApp {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Foo',
//     ;)
//   )
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  late WebViewController controller;

  int selectedIndex = 0;

  itemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    // Check which item is pressed
    if (index == 0) {
      controller.loadUrl(
        "https://wehewehe.org/gsdl2.85/cgi-bin/hdict?a=p&p=home&l=haw&e=d-11000-00---off-0hdict--00-1----0-10-0---0---0direct-10-ED--4--textpukuielbert%2ctextmamaka-----0-1l--11-haw-Zz-1---Zz-1-home-back--00-4-1-00-0--4----0-0-11-00-0utfZz-8-00&q=",
      );
    } else if (index == 1) {
      controller.loadUrl(
        "https://ulukau.org/index.php?l=en",
      );
    } else if (index == 2) {
      myStack.pop();
      controller.loadUrl(myStack.pop());
    }
  }

// appBar: AppBar(
//   title: const Text('Bottom Navigation Bar'),
//   centerTitle: true,
// ),
// body: const Center(),

  Widget customBottomNavigationBar(BuildContext context) {
    double myHeight = 100.0; //Your height HERE
    return SizedBox(
      height: myHeight,
      width: MediaQuery.of(context).size.width,
      child: const TabBar(
        tabs: [
          Tab(text: 'One', icon: Icon(Icons.import_contacts, size: 20.0)),
          Tab(text: 'Two', icon: Icon(Icons.restaurant, size: 20.0)),
          Tab(text: 'Three', icon: Icon(Icons.record_voice_over, size: 20.0)),
        ],
        labelStyle: TextStyle(fontSize: 12.0),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white30,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'WEHEWEHE LAWE LIMA',
            style: TextStyle(
              color: Colors.white, // Change the color of the title
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'ʻAno Nui',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/download.png'),
              label: 'Kaniʻāina',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.arrow_back_ios_new_outlined),
              label: 'Hoʻihoʻi',
            ),
          ],
          onTap: itemTapped,
        ),

        // bottomNavigationBar: const BottomAppBar(child: Icon(Icons.home)),
        body: PopScope(
          canPop: true,
          onPopInvoked: (didPop) async {
            if (didPop) {
              return;
            }
            debugPrint("here");
            Navigator.pop(context, {'state': 'update'});
          },
          child: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl:
                "https://wehewehe.org/gsdl2.85/cgi-bin/hdict?a=p&p=home&l=haw&e=d-11000-00---off-0hdict--00-1----0-10-0---0---0direct-10-ED--4--textpukuielbert%2ctextmamaka-----0-1l--11-haw-Zz-1---Zz-1-home-back--00-4-1-00-0--4----0-0-11-00-0utfZz-8-00&q=",
            onWebViewCreated: (controller) {
              this.controller = controller;
            },
            onPageFinished: (controller) {
              createNewH1Element();
            },
            onPageStarted: (url) {
              myStack.push(url);
            },
          ),
        ),
        floatingActionButton: SizedBox(
          width: 30.0, // Set the desired width
          height: 30.0, // Set the desired height
          child: FloatingActionButton(
            onPressed: () async {
              myStack.pop();
              controller.loadUrl(myStack.pop());
            },
            child: const Icon(Icons.arrow_back, size: 20),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );

  void createNewH1Element() async {
    // Create a new h1 element
    controller.runJavascript(
        "var existingH1 = document.getElementsByTagName('h1')[0];"
        "var newH1 = document.createElement('h1');"
        "newH1.textContent = 'MOBILE';"
        "newH1.style.fontSize = '20px';"
        "newH1.style.color = '#0000ff';"
        "existingH1.parentNode.insertBefore(newH1, existingH1.nextSibling);");
  }
}
