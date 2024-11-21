import 'package:intl/intl.dart';

class WeatherModel {
  final String cityName;
  final String description;
  final double temperature;
  final double minTemperature;
  final double maxTemperature;
  final String? icon;
  final int unixTime;
  final int timezone;

  WeatherModel({
    required this.cityName,
    required this.description,
    required this.temperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.icon,
    required this.unixTime,
    required this.timezone,
  });

  WeatherModel.fromJson(Map<String, dynamic> json)
      : cityName = json['name'],
        description = json['weather'][0]['description'],
        temperature = json['main']['temp'],
        minTemperature = json['main']['temp_min'],
        maxTemperature = json['main']['temp_max'],
        icon = json['weather'][0]['icon'],
        unixTime = json['dt'],
        timezone = json['timezone'];

  DateTime get localTime => DateTime.fromMillisecondsSinceEpoch((unixTime + timezone) * 1000, isUtc: true);

  String get formattedDate =>
      '${DateFormat('EEEE').format(localTime)}, ${localTime.day}/${localTime.month}/${localTime.year}';
  String get formattedTime => DateFormat('h:mm a').format(localTime);
}
