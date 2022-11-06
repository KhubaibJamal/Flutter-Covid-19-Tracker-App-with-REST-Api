import 'package:covid_19_tracker_with_api/Services/states_services.dart';
import 'package:covid_19_tracker_with_api/View/detaile_country_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();
  StatesServices statesServices = StatesServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: "Search country here",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: statesServices.countriesListApi(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                    itemCount: 8,
                    itemBuilder: ((context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Container(
                                height: 50,
                                width: 70,
                                color: Colors.white,
                              ),
                              title: Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                height: 20,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]['country'];
                      if (searchController.text.isEmpty) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) =>
                                        DetailCountriesScreen(
                                          countryName: snapshot.data![index]
                                              ['country'],
                                          countryImage: snapshot.data![index]
                                              ['countryInfo']['flag'],
                                          totalCases: snapshot.data![index]
                                              ['cases'],
                                          totalDeaths: snapshot.data![index]
                                              ['deaths'],
                                          totalRecovered: snapshot.data![index]
                                              ['recovered'],
                                          active: snapshot.data![index]
                                              ['active'],
                                          critical: snapshot.data![index]
                                              ['critical'],
                                          todayRecovered: snapshot.data![index]
                                              ['todayRecovered'],
                                          test: snapshot.data![index]['tests'],
                                        )),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                                leading: Image(
                                  height: 50.0,
                                  width: 50.0,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag']),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else if (name
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) =>
                                        DetailCountriesScreen(
                                          countryName: snapshot.data![index]
                                              ['country'],
                                          countryImage: snapshot.data![index]
                                              ['countryInfo']['flag'],
                                          totalCases: snapshot.data![index]
                                              ['cases'],
                                          totalDeaths: snapshot.data![index]
                                              ['deaths'],
                                          totalRecovered: snapshot.data![index]
                                              ['recovered'],
                                          active: snapshot.data![index]
                                              ['active'],
                                          critical: snapshot.data![index]
                                              ['critical'],
                                          todayRecovered: snapshot.data![index]
                                              ['todayRecovered'],
                                          test: snapshot.data![index]['tests'],
                                        )),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                                leading: Image(
                                  height: 50.0,
                                  width: 50.0,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag']),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
