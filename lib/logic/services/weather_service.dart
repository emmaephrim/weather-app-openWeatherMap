import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:weather_app_openweathermap/logic/models/weather_model.dart';

import '../../constants/api_key.dart';

class WeatherService {
  Future<WeatherModel?> fetchWeather(String city) async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      return null;
    }
  }
}

// Weather Info Widget
class WeatherInfo extends StatelessWidget {
  final WeatherModel weather;
  const WeatherInfo({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on,
              size: 30,
              color: Colors.white,
            ),
            const SizedBox(width: 5),
            Text(weather.cityName, style: const TextStyle(fontSize: 24)),
          ],
        ),
        const SizedBox(height: 60),
        Text(weather.formattedTime, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
        Text(
          weather.formattedDate,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        Image.network(
          "https://openweathermap.org/img/w/${weather.icon}.png",
          scale: 0.5,
        ),
        Text(weather.description, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 10),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(
                  children: [
                    const Text("Min Temp", style: TextStyle(fontSize: 16)),
                    Text("${weather.minTemperature}°C", style: const TextStyle(fontSize: 18)),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    const Text("Max Temperature", style: TextStyle(fontSize: 16)),
                    Text("${weather.maxTemperature}°C", style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ]),
            )),
      ],
    );
  }
}
