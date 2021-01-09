import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child:SpinKitChasingDots(
          color:Colors.green[700],
          size:50
        )
      ),
      
    );
  }
}