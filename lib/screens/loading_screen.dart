// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:weather_app/networking/location.dart';
import 'package:weather_app/networking/network.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/screens/weatherScreen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double latitude;
  late double longitude;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;

    final url = Uri.parse(
        'https://open-weather13.p.rapidapi.com/city/fivedaysforcast/$latitude/$longitude&units=metric');

    Network network = Network(url);

    // ignore: unused_local_variable
    var weatherData = await network.getData();
    //print(weatherData);
   
    if (weatherData != null) {
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return WeatherScreen(
          weatherData: weatherData,
        );
      }));
    } else {
      print('failed to fetch weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
