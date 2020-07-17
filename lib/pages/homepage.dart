import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc/bloc/bloc.dart';
import 'package:weather_bloc/models/api_response.dart';
import 'package:weather_bloc/models/weather.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final weatherBloc = WeatherBloc(InitialWeatherState());

  @override
  void dispose() {
    super.dispose();
    weatherBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocProvider(
        create: (context) => weatherBloc,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          child: BlocBuilder<WeatherBloc, WeatherState>(
              bloc: weatherBloc,
              builder: (context, state){
                if(state is InitialWeatherState){
                  return buildInitialInput();
                } else if ( state is WeatherLoading){
                  return buildLoading();
                } else if (state is WeatherLoaded){
                  return buildColumnWithData(state.response);
                } else {
                  return Container();
                }
              }
          ),
        ),
      ),
    );
  }
  Widget buildInitialInput() {
    return Center(
      child: CityInputField(),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  // Builds widgets from the starter UI with custom weather data
  Column buildColumnWithData(ApiResponse<Weather> response) {
    Weather weather = response.data;
    return response.error ? Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          "Error occured: ${response.errorMessage}",
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
        CityInputField(),
      ],
    ): Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.cityName,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          // Display the temperature with 1 decimal place
          "${weather.temperature.toStringAsFixed(1)} °C",
          style: TextStyle(fontSize: 80),
        ),
        CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatefulWidget {
  const CityInputField({
    Key key,
  }) : super(key: key);

  @override
  _CityInputFieldState createState() => _CityInputFieldState();
}

class _CityInputFieldState extends State<CityInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: submitCityName,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a city",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitCityName(String cityName) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.add(GetWeather(cityName));
  }
}