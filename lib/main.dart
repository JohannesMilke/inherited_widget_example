import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inherited_widget_example/page/color_page.dart';
import 'package:inherited_widget_example/page/counter_page.dart';
import 'package:inherited_widget_example/widget/state_widget.dart';
import 'package:inherited_widget_example/widget/button_widget.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Inherited Widget';

  @override
  Widget build(BuildContext context) => StateWidget(
        child: Builder(
          builder: (context) {
            final state = StateInheritedWidget.of(context).state;

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: title,
              theme: ThemeData(
                scaffoldBackgroundColor: state.backgroundColor,
                primaryColor: Colors.white,
              ),
              home: MainPage(title: title),
            );
          },
        ),
      );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final counter = StateInheritedWidget.of(context).state.counter;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$counter',
              style: TextStyle(fontSize: 100),
            ),
            const SizedBox(height: 47),
            ButtonWidget(
              text: 'Change Color',
              onClicked: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ColorPage(),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ButtonWidget(
              text: 'Change Counter',
              onClicked: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => CounterPage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
