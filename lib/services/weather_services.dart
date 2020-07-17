import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:weather_bloc/models/api_response.dart';
import 'package:weather_bloc/models/weather.dart';

class WeatherService{

  final Dio _dio = Dio();
  final APIKEY = "2b2166c539d1e7065d694c38c2c44c3b";
  final endpoint = "https://api.openweathermap.org/data/2.5/weather?";

  Future<ApiResponse<Weather>> getWeather(String cityName) async {
    try{
      Response response = await _dio.get(endpoint, queryParameters: {
        "q": cityName,
        "appid": APIKEY,
        "units": "metric"
      });
      print(response.data);
      final jsonData = response.data;
      print("done");
      if(response.statusCode == 200){
        final weather = Weather(cityName: jsonData["name"], temperature: jsonData["main"]["temp"].toDouble());
        return ApiResponse<Weather>(error: false, data: weather);
      } else {
        return ApiResponse<Weather>(error: true, errorMessage: jsonData["cod"]);
      }
    } catch (error, stacktrace){
      print(error);
      print(stacktrace);
      return ApiResponse<Weather>(error: true, errorMessage: error.toString());
    }
  }

}