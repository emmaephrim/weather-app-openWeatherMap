class WeatherModel {
  final String cityName;
  final String description;
  final double temperature;
  final double minTemperature;
  final double maxTemperature;

  WeatherModel({
    required this.cityName,
    required this.description,
    required this.temperature,
    required this.minTemperature,
    required this.maxTemperature,
  });

  WeatherModel.fromJson(Map<String, dynamic> json)
      : cityName = json['name'],
        description = json['weather'][0]['description'],
        temperature = json['main']['temp'],
        minTemperature = json['main']['temp_min'],
        maxTemperature = json['main']['temp_max'];
}
