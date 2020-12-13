import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[200],
      child: Center(
        child:SpinKitChasingDots(
          color:Colors.brown,
          size:50
        )
      ),
      
    );
  }
}