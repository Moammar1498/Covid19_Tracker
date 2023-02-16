import 'package:covid19_tracker/view/world_states.dart';
import 'package:flutter/material.dart';

class DetailedScreen extends StatefulWidget {
  String name, image;
  int totalcases, totaldeaths, totalrecovered, tests, todayrecovered, critical, active;
   DetailedScreen({
    required this.name,
    required this.image,
    required this.totalcases,
    required this.totaldeaths,
    required this.todayrecovered,
    required this.tests,
    required this.critical,
    required this.active,
    required this.totalrecovered
});

  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      ReusableRow(text: 'Total Cases', value: widget.totalcases.toString()),
                      ReusableRow(text: 'Total Recovered', value: widget.totalrecovered.toString()),
                      ReusableRow(text: 'Total Deaths', value: widget.totaldeaths.toString()),
                      ReusableRow(text: 'Today Recovered', value: widget.todayrecovered.toString()),
                      ReusableRow(text: 'Tests', value: widget.tests.toString()),
                      ReusableRow(text: 'Active', value: widget.active.toString()),
                      ReusableRow(text: 'Critical', value: widget.critical.toString())
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      )
    );
  }
}
