import 'package:flutter/material.dart';
import 'package:state_management/views/Home.dart';

void main()=>runApp(
    MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
        fontFamily: 'Lato',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context)=>home(),
      },
    )
);
