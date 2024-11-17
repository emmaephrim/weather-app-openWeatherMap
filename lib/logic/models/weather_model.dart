class WeatherModel {
  final String cityName;
  final String description;
  final double temperature;
  final double minTemperature;
  final double maxTemperature;
  final String? icon;

  WeatherModel({
    required this.cityName,
    required this.description,
    required this.temperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.icon,
  });

  WeatherModel.fromJson(Map<String, dynamic> json)
      : cityName = json['name'],
        description = json['weather'][0]['description'],
        temperature = json['main']['temp'],
        minTemperature = json['main']['temp_min'],
        maxTemperature = json['main']['temp_max'],
        icon = json['weather'][0]['description'];
}
