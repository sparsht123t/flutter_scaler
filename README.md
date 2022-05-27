<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

A Flutter Widget to show different types of scales or rulers with selected value.
A simple scale ruler for adding length in feet and inches and cms ([pub.dev](https://pub.dev/packages/flutter_scaler)).
## Screenshots
![scale_example](https://user-images.githubusercontent.com/51333268/170699790-6f8deee6-1ec9-4ef3-862c-51938269e409.png)


A Flutter Widget to show different types of scales or rulers with selected value.

## Getting started

 ```yaml
 dependencies:
    flutter:
      sdk: flutter
    flutter_scaler:
```

## Usage



```dart
import 'package:final_scaler/scale.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScalePickerController _scalePickerController = ScalePickerController();
  double scaleValue = 0;
  double verticalScaleValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ScalePicker(
                height: 80,
                width: MediaQuery.of(context).size.width,
                isInvertedScale: true,
                backgroundColor:
                    Colors.greenAccent[200]!.withOpacity(0.5) as Color,
                bigTickColor: Colors.greenAccent,
                initialValue: 33,
                onValueChange: (value) {
                  setState(() => scaleValue = value.toDouble());
                },
                scalePickerController: _scalePickerController),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ScalePicker(
                    backgroundColor:
                        Colors.yellowAccent[200]!.withOpacity(0.5) as Color,
                    isAxisVertical: true,
                    width: 120,
                    height: MediaQuery.of(context).size.height - 300,
                    isInvertedScale: false,
                    bigTickColor: Colors.greenAccent,
                    initialValue: 33,
                    onValueChange: (value) {
                      setState(() => scaleValue = value.toDouble());
                    },
                    scalePickerController: _scalePickerController),
                ScalePicker(
                    isAxisVertical: true,
                    backgroundColor:
                        Colors.blueAccent[200]!.withOpacity(0.5) as Color,
                    width: 120,
                    height: MediaQuery.of(context).size.height - 300,
                    isInvertedScale: true,
                    bigTickColor: Colors.greenAccent,
                    initialValue: 33,
                    shouldTextBeAlignedHorizontallyOnVerticalScroll: true,
                    onValueChange: (value) {
                      setState(() => scaleValue = value.toDouble());
                    },
                    scalePickerController: _scalePickerController),
                ScalePicker(
                    isAxisVertical: true,
                    backgroundColor: Colors.black.withOpacity(0.5) as Color,
                    width: 120,
                    height: MediaQuery.of(context).size.height - 300,
                    isInvertedScale: true,
                    bigTickColor: Colors.greenAccent,
                    initialValue: 33,
                    onValueChange: (value) {
                      setState(() => scaleValue = value.toDouble());
                    },
                    scalePickerController: _scalePickerController),
              ],
            ),
            ScalePicker(
                backgroundColor: Colors.pink[200]!.withOpacity(0.5) as Color,
                height: 80,
                width: MediaQuery.of(context).size.width,
                isInvertedScale: false,
                bigTickColor: Colors.greenAccent,
                initialValue: 33,
                onValueChange: (value) {
                  setState(() => scaleValue = value.toDouble());
                },
                scalePickerController: _scalePickerController),
          ],
        ),
      ),
    );
  }
}

```

