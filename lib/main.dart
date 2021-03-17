import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_weather/weather_model.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pertemuan 9',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Weather'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller;
  WeatherModel _weather;
  String _lokasi;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _weather = WeatherModel();
    _lokasi = '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() async {
    var client = http.Client();
    try {
      var param = {"q": _lokasi, "APPID": "YOUR_API_KEY"};
      var uri = Uri.https('api.openweathermap.org', '/data/2.5/weather', param);
      var uriResponse = await client.get(uri);
      setState(() {
        _weather =
            WeatherModel.fromJson(json.decode(uriResponse.body.toString()));
      });
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Text(
                'Aplikasi Cuaca',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                '06TPLE010',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '181011400928',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Reza Fahlevi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                      ),
                      child: Image.network(
                        'https://w7.pngwing.com/pngs/624/6/png-transparent-weather-forecasting-ios-7-weather-blue-text-weather-icon.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Wind Speed : ' +
                                  _weather?.wind?.speed.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              'Temp : ' + _weather?.main?.temp.toString(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.normal),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              'Humadity : ' +
                                  _weather?.main?.humidity.toString(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.normal),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Masukkan nama daerah',
                ),
                onChanged: (val) {
                  setState(() {
                    _lokasi = val;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                height: 50,
                child: ElevatedButton(
                  onPressed: _onTap,
                  child: Text('Tampilkan Data Cuaca'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
