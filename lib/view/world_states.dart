import 'package:covid19_tracker/models/WorldStatesModel.dart';
import 'package:covid19_tracker/view/countries_list_screen.dart';
import 'package:covid19_tracker/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin {

  late final  AnimationController _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color> [
    Color(0xff4285f4),
    Color(0xff1aa260),
    Color(0xffde5246)
  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .01,),
            FutureBuilder(future: statesServices.fetchWorldStates(),
                builder: (context , AsyncSnapshot<WorldStatesModel> snapshot){
              if(!snapshot.hasData){
                return Expanded(
                    flex: 1,
                    child: SpinKitFadingCircle(
                  color: Colors.white,
                      size: 50,
                      controller: _controller,
                ));
              }else{ return
                Column(
                  children: [
                    PieChart(
                      dataMap: {
                        'Total' : double.parse(snapshot.data!.cases!.toString()),
                        'Recovered' : double.parse(snapshot.data!.recovered!.toString()),
                        'Deaths' : double.parse(snapshot.data!.deaths!.toString()),
                      },
                      chartValuesOptions: ChartValuesOptions(
                        showChartValuesInPercentage: true
                      ),
                      legendOptions: LegendOptions( legendPosition: LegendPosition.left),
                      chartRadius: MediaQuery.of(context).size.width/3.2,
                      animationDuration: Duration(microseconds: 1200),
                      chartType: ChartType.ring,
                      colorList: colorList,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height *.04),
                      child: Card(
                        child: Column(
                          children: [
                            ReusableRow(text: 'Total', value: snapshot.data!.cases.toString(),),
                            ReusableRow(text: 'Recovered', value: snapshot.data!.recovered.toString(),),
                            ReusableRow(text: 'Deaths', value: snapshot.data!.deaths.toString(),),
                            ReusableRow(text: 'Active', value: snapshot.data!.active.toString(),),
                            ReusableRow(text: 'Today Cases', value: snapshot.data!.todayCases.toString(),),
                            ReusableRow(text: 'Today Deaths', value: snapshot.data!.todayDeaths.toString(),),
                            ReusableRow(text: 'Today Recovered', value: snapshot.data!.todayRecovered.toString(),)
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => CountriesListScreen()));
                  },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xff1aa260),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(child: Text('Tracking Countries')
                          ,),
                      ),
                    )
                  ],
                );
              }
            })
          ],
        ),
      )),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String text, value;
   ReusableRow({Key? key, required this.text, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5, right: 10),
      child: Column(
        children: [Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text),
            Text(value)
          ],
        ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}
