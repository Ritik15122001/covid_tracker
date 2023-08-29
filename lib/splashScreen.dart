import 'dart:async';

import 'package:covid_tracker/country.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late final AnimationController _Anicontroller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this)..repeat();
  void dispose(){
    super.dispose();
    _Anicontroller.dispose();
  }
  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds:3),
    ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> Countries()))
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedBuilder(animation: _Anicontroller,
                    child: Container(
                      height: 200,
                      width: 200,
                      child: const Center(
                        child: Image(image: AssetImage('images/virus.png')),
                      ),
                    ),
                    builder: (BuildContext context, Widget? child){
                  return Transform.rotate(angle: _Anicontroller.value*2.0*math.pi,
                  child: child,
                  );
                }),
                SizedBox(height: MediaQuery.of(context).size.height* .08,),
                const Text('  Covid-19 \nTracker App',style: TextStyle(
                  fontWeight:FontWeight.bold,fontSize: 30,
                ),),
              ],
            ),
          )
      ),
    );
  }
}
