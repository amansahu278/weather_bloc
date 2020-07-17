import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc/services/weather_services.dart';
import 'bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState>{
  
  WeatherBloc(WeatherState initialState) : super(initialState);
  
  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if(event is GetWeather){
      yield WeatherLoading();
      final response = await WeatherService().getWeather(event.cityName);
      yield WeatherLoaded(response);
    }
  }
}