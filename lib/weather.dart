
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  DateTime _currentdate = new DateTime.now();
  DateTime _currenttime = new DateTime.now();

  var temp;
  var wind;
  var hum;
  var des;
  var tempc;
  var tempcc;

  Future GetWeather() async {
    http.Response response = await http.get("http://api.openweathermap.org/data/2.5/weather?q=Dhaka&appid=a20aa01ab9c962182374dfe4bb249827");
    var result = jsonDecode(response.body);

    setState(() {
      this.temp = result ["main"] ["temp"];
      tempc = (temp-273.15);
      tempcc = double.parse(tempc.toStringAsFixed(0));
      this.des = result ["weather"] [0] ["main"];
      this.hum = result ["main"] ["humidity"];
      this.wind = result ["wind"] ["speed"];
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.GetWeather();
  }

  @override
  Widget build(BuildContext context) {
    String _formatedate = new DateFormat.yMMMd().format(_currentdate);

    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Application"),
      ),
      
      body: Center(
        child: Container(
         // width: double.infinity,
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage("assets/w.jpg",),
          //   )
          // ),
          child: Center(
            child: Column(
              children: [
                Text("Current weather in Dhaka",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 30,
                ),
                ),
                SizedBox(height: 20,),
                Text(tempcc != null ? tempcc.toString() + "\u00B0": "Loading",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.redAccent,
                ),
                ),
                SizedBox(height: 20,),
                

                Text(des != null ? des.toString(): "Loading",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.redAccent,
                  ),
                ),
                SizedBox(height: 70,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(tempcc != null ? tempcc.toString()+"Temperature \u00B0": "Loading",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text(des != null ? des.toString(): "Loading",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text(wind != null ? wind.toString() : "Loading",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text(hum != null ? hum.toString():"Loading",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
                Text('Date: $_formatedate'),
              ],
            ),
          ),
        ),
      )
    );
  }
}
