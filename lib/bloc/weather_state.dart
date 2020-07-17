import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather_bloc/models/api_response.dart';
import 'package:weather_bloc/models/weather.dart';

@immutable
abstract class WeatherState extends Equatable{
  WeatherState([List props = const []]);

  @override
  List<Object> get props => [props];
}

class InitialWeatherState extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  ApiResponse<Weather> response;

  WeatherLoaded(this.response);

  @override
  List<Object> get props => [response];
}