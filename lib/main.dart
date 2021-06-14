import 'package:flutter/material.dart';
import 'package:state_management/views/Home.dart';

void main()=>runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context)=>home(),
      },
    )
);
