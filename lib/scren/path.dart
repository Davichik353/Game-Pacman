import 'package:flutter/material.dart';

class MyPath extends StatelessWidget {
 MyPath({
  this.child,this.innerColor,this.outerColor});
final innerColor;
final outerColor;
final child;
  @override
  Widget build(BuildContext context) {
   return Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.all(12),
                          color: outerColor,
                          child:  ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                         
                          color: innerColor,
                          child: Center(child: child),
                        ),
                      ),
                        ),
                      ),
                    );
  }
}