import 'dart:async';

import 'package:flutter/material.dart';

void main() {
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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const DealsCarousel(),
    );
  }
}


class DealsCarousel extends StatefulWidget {
  const DealsCarousel({super.key});

  @override
  State<DealsCarousel> createState() => _DealsCarouselState();
}

class _DealsCarouselState extends State<DealsCarousel> {
  final PageController pageController = PageController();
  Timer? myTimer;
  int currentPage = 0;
   int maxItems = 10;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    myTimer?.cancel();
    pageController.dispose();
    super.dispose();
  }

  void startTimer() {
    myTimer?.cancel();
    myTimer = Timer( Duration(seconds: 2), autoScroll);
  }

  void autoScroll() {
    if (currentPage < maxItems - 1) {
      currentPage++;
      pageController.animateToPage(
        currentPage,
        duration:  Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 200,
          child: PageView.builder(
            controller: pageController,
            itemCount: maxItems,
            onPageChanged: (index) {
              setState(() => currentPage = index);
              startTimer();
            },
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    "${index + 1}",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10),

Container(
  margin:  EdgeInsets.only(top: 12),
  width: 200,
  height: 8,
  decoration: BoxDecoration(
    color: Colors.black,
    borderRadius: BorderRadius.circular(4),
  ),
  child: LayoutBuilder(
    builder: (context, constraints) {
      double segmentWidth = constraints.maxWidth / maxItems;
      return Stack(
        children: [
          AnimatedPositioned(
            duration:  Duration(milliseconds: 200),
            left: currentPage * segmentWidth,
            child: Container(
              width: segmentWidth,
              height: constraints.maxHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      );
    },
  ),
),

      ],
    ),
      ),
    );
  }
}
