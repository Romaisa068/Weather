// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:weather_app/constant.dart';

// ignore: constant_identifier_names
var degree = '\u00B0C';

class WeatherScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const WeatherScreen({this.weatherData});

  // ignore: prefer_typing_uninitialized_variables
  final weatherData;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late int temp;
  late int tommTemp;
  late String name;
  late String description;
  late int id;

  @override
  void initState() {
    super.initState();
    updateUi(widget.weatherData);
  }

  void updateUi(dynamic data) {
    if (data == null) {
      print('no data recieved');
    } else {
      try {
        double temperature = data['list'][0]['main']['temp'];
        temp = temperature.toInt();
        double tommTemperatue = data['list'][8]['main']['temp'];
        tommTemp = tommTemperatue.toInt();
        name = data['city']['name'];
        description = data['list'][0]['weather'][0]['description'];
        id = data['list'][0]['weather'][0]['id'];
      } catch (error) {
        print('error in parsind data:  $error');
        temp = 0;
        name = "Unknown location";
        description = "No description available";
        id = 0;
      }
    }

    //list[0].main.temp
//list[0].weather[0].main
//list[0].weather[0].id
//list[4].main.temp
//list[1].main.temp
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          const Positioned.fill(
            child: Image(
              image: AssetImage('images/back.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 350.0,
                  width: double.infinity,
                  decoration: KBoxDeco,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          height: 26.0,
                        ),
                        Text(
                          name,
                          style: KTextStyle,
                        ),
                        const SizedBox(
                          height: 26.0,
                        ),
                        // const SizedBox(
                        //   height: 50.0,
                        //   width: 50.0,
                        //   child: Image(
                        //     image: AssetImage('images/sun.gif'),
                        //   ),
                        // ),
                        const Icon(
                          Icons.sunny,
                          size: 50.0,
                          color: Colors.amber,
                        ),
                        const SizedBox(
                          height: 26.0,
                        ),
                        Text('$temp$degree', style: KTempStyle),
                        Text(
                          description,
                          style: KTextStyle.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                // ignore: sized_box_for_whitespace
                Container(
                  height: 120.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      WeatherHourCard(
                        temp: '30$degree',
                        icon: Icons.shower,
                        time: 'now',
                      ),
                      WeatherHourCard(
                        temp: '29$degree',
                        icon: Icons.sunny,
                        time: '09AM',
                      ),
                      WeatherHourCard(
                        temp: '31$degree',
                        icon: Icons.sunny_snowing,
                        time: '12PM',
                      ),
                      WeatherHourCard(
                        temp: '35$degree',
                        icon: Icons.shower,
                        time: '03PM',
                      ),
                      WeatherHourCard(
                        temp: '39$degree',
                        icon: Icons.sunny,
                        time: '05PM',
                      ),
                      WeatherHourCard(
                        temp: '28$degree',
                        icon: Icons.snowing,
                        time: '10PM',
                      ),
                    ],
                  ),
                ),

                Container(
                  width: 250,
                  height: 130.0,
                  decoration: KBoxDeco.copyWith(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(150.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Tomorrow',
                          style: KTextStyle.copyWith(
                              color: const Color.fromARGB(255, 242, 242, 199),
                              fontSize: 20.0),
                        ),
                        Text(
                          '$tommTemp$degree',
                          style: KTempStyle,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class WeatherHourCard extends StatelessWidget {
  const WeatherHourCard(
      {super.key, required this.temp, required this.icon, required this.time});

  final String temp;
  final IconData icon;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: const Color(0x5953AAC0),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(192, 33, 69, 78),
              blurRadius: 5.0,
              spreadRadius: 3.0,
            )
          ]),
      child: Column(
        children: [
          Text(temp),
          Icon(icon),
          Text(time),
        ],
      ),
    );
  }
}
