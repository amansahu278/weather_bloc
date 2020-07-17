import 'package:dio/dio.dart';
import 'package:weather_bloc/models/api_response.dart';
import 'package:weather_bloc/models/weather.dart';

class WeatherService{

  final Dio _dio = Dio();
  final APIKEY = "2b2166c539d1e7065d694c38c2c44c3b";
  final endpoint = "api.openweathermap.org/data/2.5/weather?";

  Future<ApiResponse<Weather>> getWeather(String cityName) async {

    try{
      Response response = await _dio.get(endpoint, queryParameters: {
        "q": cityName,
        "appid": APIKEY,
        "units": "metric"
      });
      if(response.statusCode == 200){
        
      } else {

      }
    } catch (error, stacktrace){
      return ApiResponse(error: true, errorMessage: stacktrace.toString());
    }
  }


}