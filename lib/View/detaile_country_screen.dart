import 'package:covid_19_tracker_with_api/Widget/reusable_row_widget.dart';
import 'package:flutter/material.dart';

class DetailCountriesScreen extends StatefulWidget {
  String countryName;
  String countryImage;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;
  DetailCountriesScreen({
    required this.countryName,
    required this.countryImage,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<DetailCountriesScreen> createState() => _DetailCountriesScreenState();
}

class _DetailCountriesScreenState extends State<DetailCountriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.countryName),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .06,
                        ),
                        ReusableRowWidget(
                          title: "Cases",
                          value: widget.totalCases.toString(),
                        ),
                        ReusableRowWidget(
                          title: "Deaths",
                          value: widget.totalDeaths.toString(),
                        ),
                        ReusableRowWidget(
                          title: "Recovered",
                          value: widget.todayRecovered.toString(),
                        ),
                        ReusableRowWidget(
                          title: "Active",
                          value: widget.active.toString(),
                        ),
                        ReusableRowWidget(
                          title: "Critical",
                          value: widget.critical.toString(),
                        ),
                        ReusableRowWidget(
                          title: "Total Recovered",
                          value: widget.totalRecovered.toString(),
                        ),
                        ReusableRowWidget(
                          title: "Test",
                          value: widget.test.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.countryImage),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
