import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inherited_widget_example/widget/state_widget.dart';
import 'package:inherited_widget_example/widget/button_widget.dart';

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 48),
              child: buildTextField(onSubmitted: setCounter),
            ),
            const SizedBox(height: 24),
            ButtonWidget(
              text: 'Update Counter',
              onClicked: () => setCounter(controller.text),
            ),
            const SizedBox(height: 64),
            ButtonWidget(
              text: 'Increment Counter',
              onClicked: incrementCounter,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    @required ValueChanged<String> onSubmitted,
  }) =>
      TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.number,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: 'Counter',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.white),
          ),
          hintStyle: TextStyle(color: Colors.white70),
        ),
      );

  void incrementCounter() {
    final provider = StateInheritedWidget.of(context);
    provider.incrementCounter();

    Navigator.pop(context);
  }

  void setCounter(String value) {
    try {
      final counter = int.tryParse(value);
      final provider = StateInheritedWidget.of(context);
      provider.setCounter(counter);

      Navigator.pop(context);
    } catch (e) {}
  }
}
