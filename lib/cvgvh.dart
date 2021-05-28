import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  var _tem, _hum, _win, _newtem;



  Future getweatherinfo() async{
    http.Response _respone = await http.get("https://api.openweathermap.org/data/2.5/weather?q=Dhaka&appid=32511dee4a22469574a36f13f8be3c55");

    var _forjsondec = jsonDecode(_respone.body);

    setState(() {
      this._tem = _forjsondec ["main"] ["temp"];
      this._hum = _forjsondec ["main"] ["humidity"];
      this._win = _forjsondec ["wind"] ["speed"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getweatherinfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            Text("Location Dhaka"),
            SizedBox(height: 20,),
            Row(
              children: [
                Text('Temperature: '),
                Text(_tem != null ? _tem.toString()+"\u00B0" : "not send")
              ],
            ),

            SizedBox(height: 10,),
            Row(
              children: [
                Text('Humidity: '),
                Text(_hum != null ? _hum.toString()+"%" : "not send")
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text('Wind: '),
                Text(_win != null ? _win.toString()+"km/h" : "not send")
              ],
            )
          ],
        ),
      ),
    );
  }
}
