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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.green[300]!, Colors.yellow[400]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
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
