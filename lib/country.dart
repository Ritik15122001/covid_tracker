import 'package:covid_tracker/Model/DataModel.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'Model/Services/Utilities/states_service.dart';
import 'package:covid_tracker/countriresList.dart';
class Countries extends StatefulWidget {
  const Countries({super.key});

  @override
  State<Countries> createState() => _CountriesState();
}

class _CountriesState extends State<Countries> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
     const Color(0xff4285f4),
    const Color(0xff1aa260),
     const Color(0xffde5246)

  ];
  @override
  Widget build(BuildContext context) {
    statesServices stateservices = statesServices();
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height* .01,),
            FutureBuilder(
             future: stateservices.fetchRecord(),
                builder: (context,AsyncSnapshot<DataModel> snapshot) {
               if (!snapshot.hasData) {
               return Expanded(
                flex: 1,
                child: SpinKitFadingCircle(
                 color: Colors.white,
                 size: 50.0,
                  controller: _controller,
            ),
        );
      } else {
        return Column(
          children: [
            PieChart(dataMap:  {
              "Total": double.parse(snapshot.data!.cases!.toString()),
              "Recovered": double.parse(snapshot.data!.recovered.toString()),
              "Deaths": double.parse(snapshot.data!.deaths.toString()),
            },
              //   legendOptions: const LegendOptions(
              //   legendPosition: LegendPosition.left
              // ),
              chartValuesOptions: const ChartValuesOptions(
                showChartValuesInPercentage: true,
              ),
              chartRadius: MediaQuery.of(context).size.width/3.2,
              animationDuration: const Duration(milliseconds: 1200),
              chartType: ChartType.ring,
              colorList: colorList,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .01),
              child: Card(
                child: Column(
                  children: [
                    ResuableRow(title: 'Total', value: snapshot.data!.cases.toString(),),
                    ResuableRow(title: 'Deaths', value: snapshot.data!.deaths.toString(),),
                    ResuableRow(title: 'Recovered', value: snapshot.data!.recovered.toString(),),
                    ResuableRow(title: 'Active', value: snapshot.data!.active.toString(),),
                    ResuableRow(title: 'Critical', value: snapshot.data!.critical.toString(),),
                    ResuableRow(title: 'Today Death', value: snapshot.data!.todayDeaths.toString(),),
                    ResuableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString(),),


                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder:(context)=>CountriesList()));
                  },
              child:
              Container(
                height: 50,
                decoration: BoxDecoration(
                    color: const Color(0xff1aa260),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: const Center(
                  child: Text('Track Countries',
                    style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ),
            // )
            )
          ],
        );
      }
    }),
        ],
        ),
      ),
    ),
    );
  }
}
class  ResuableRow extends StatelessWidget {
  String title, value;
   ResuableRow({Key?key,required this.title,required this.value}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Text(title),
                Text(value),
            ],
          ),
          const SizedBox(height: 5,),
          const Divider()
        ],
      ),
    );
  }
}
