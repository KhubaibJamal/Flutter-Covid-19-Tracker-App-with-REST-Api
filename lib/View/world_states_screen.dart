import 'package:covid_19_tracker_with_api/Models/WorldStatedModel.dart';
import 'package:covid_19_tracker_with_api/Services/states_services.dart';
import 'package:covid_19_tracker_with_api/View/countries_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import '../Widget/reusable_row_widget.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({Key? key}) : super(key: key);

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 1000), vsync: this)
    ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  // class where store all the method
  StatesServices statesServices = StatesServices();

  final colorList = [
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                FutureBuilder(
                  future: statesServices.fetchWorldStatesRecords(),
                  builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50,
                          controller: _controller,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Something Went Wrong\n${snapshot.error}');
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total":
                                  double.parse(snapshot.data!.cases.toString()),
                              "Recovers": double.parse(
                                  snapshot.data!.recovered.toString()),
                              "Deaths": double.parse(
                                  snapshot.data!.deaths.toString()),
                            },
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true,
                              showChartValuesOutside: true,
                              showChartValueBackground: true,
                              showChartValues: true,
                              decimalPlaces: 2,
                            ),
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.2,
                            animationDuration:
                                const Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: colorList,
                            chartLegendSpacing: 32,
                            initialAngleInDegree: 0,
                            legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left,
                              showLegends: true,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * .06),
                            child: Card(
                              child: Column(
                                children: [
                                  ReusableRowWidget(
                                    title: "Cases",
                                    value: snapshot.data!.cases.toString(),
                                  ),
                                  ReusableRowWidget(
                                    title: "Deaths",
                                    value: snapshot.data!.deaths.toString(),
                                  ),
                                  ReusableRowWidget(
                                    title: "Recovered",
                                    value: snapshot.data!.recovered.toString(),
                                  ),
                                  ReusableRowWidget(
                                    title: "Active",
                                    value: snapshot.data!.active.toString(),
                                  ),
                                  ReusableRowWidget(
                                    title: "Critical",
                                    value: snapshot.data!.critical.toString(),
                                  ),
                                  ReusableRowWidget(
                                    title: "Today Deaths",
                                    value:
                                        snapshot.data!.todayDeaths.toString(),
                                  ),
                                  ReusableRowWidget(
                                    title: "Today Recovered",
                                    value: snapshot.data!.todayRecovered
                                        .toString(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) =>
                                      const CountriesListScreen()),
                                ),
                              );
                            },
                            child: Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: const Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: const Center(
                                child: Text(
                                  "Track Countries",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
