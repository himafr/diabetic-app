// import 'dart:async';

// import 'package:clima/services/location.dart';
// import 'package:clima/services/networking.dart';
// import 'package:clima/utilities/urls.dart';

// class WeatherModel {
//   Future<dynamic> getCityWeather(String cityName) async {
//     var url = weatherLink(query: {'q': cityName});
//     NetworkHelper networkHelper = NetworkHelper(url: url);
//     var weatherData = await networkHelper.getData();
//     return weatherData;
//   }

//   Future<dynamic> getLocationWeather() async {
//     Location location = Location();
//     await location.determinePosition();
//     var url = weatherLink(
//         query: {'lat': '${location.lat}', 'lon': '${location.lang}'});
//     NetworkHelper networkHelper = NetworkHelper(url: url);
//     var weatherData = await networkHelper.getData();
//     return weatherData;
//   }

//   String getWeatherIcon(int condition) {
//     if (condition < 300) {
//       return '🌩';
//     } else if (condition < 400) {
//       return '🌧';
//     } else if (condition < 600) {
//       return '☔️';
//     } else if (condition < 700) {
//       return '☃️';
//     } else if (condition < 800) {
//       return '🌫';
//     } else if (condition == 800) {
//       return '☀️';
//     } else if (condition <= 804) {
//       return '☁️';
//     } else {
//       return '🤷‍';
//     }
//   }

//   String getMessage(int temp) {
//     if (temp > 25) {
//       return 'It\'s 🍦 time';
//     } else if (temp > 20) {
//       return 'Time for shorts and 👕';
//     } else if (temp < 10) {
//       return 'You\'ll need 🧣 and 🧤';
//     } else {
//       return 'Bring a 🧥 just in case';
//     }
//   }
// }
