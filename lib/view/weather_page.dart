import 'package:flutter/material.dart';
import 'package:weather_app_openweathermap/logic/services/weather_service.dart';

import '../logic/models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _controller = TextEditingController();
  WeatherModel? _weatherData;
  String _city = '';
  bool _isLoading = false;

  Future<void> _fetchWeather() async {
    setState(() {
      _isLoading = true;
    });
    if (_city.isNotEmpty) {
      WeatherModel? weather = await _weatherService.fetchWeather(_city);
      setState(() {
        _weatherData = weather;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primaryContainer;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          color,
          color.brighten()!,
          color.brighten(33),
          color.brighten(50),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SearchBar(
                  trailing: const [
                    Icon(Icons.search),
                  ],
                  controller: _controller,
                  onSubmitted: (value) {
                    setState(() {
                      _city = value;
                    });
                    _fetchWeather();
                  },
                ),
                // TextField(
                //   controller: _controller,
                //   decoration: InputDecoration(
                //     // labelText: 'City',
                //     suffixIcon: const Icon(Icons.search),
                //     hintText: 'Enter city name',
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(20.0),
                //       borderSide: BorderSide.none,
                //     ),
                //     filled: true,
                //     fillColor: Colors.white70,
                //   ),
                //   onSubmitted: (value) {
                //     setState(() {
                //       _city = value;
                //     });
                //     _fetchWeather();
                //   },
                // ),
                const SizedBox(height: 20),
                // const
                _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white70,
                        ),
                      )
                    : _weatherData != null
                        ? WeatherInfo(weather: _weatherData!)
                        : const Text("Not Data Available"),
              ],
            )),
      ),
    );
  }
}

extension on Color {
  Color brighten([int percent = 10]) {
    assert(
      1 <= percent && percent <= 100,
      'percentage must be between 1 and 100',
    );
    final p = percent / 100;
    return Color.fromARGB(
      alpha,
      red + ((255 - red) * p).round(),
      green + ((255 - green) * p).round(),
      blue + ((255 - blue) * p).round(),
    );
  }
}
