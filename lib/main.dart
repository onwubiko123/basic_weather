import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() =>
  runApp(const MaterialApp(
    title: "Weather App",
    home: Home(),
  ));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState(); 
}

class _HomeState extends State<Home> {

  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  Future getweather () async {
    http.Response response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=Lagos&appid=75a823d2b60058a8819cf82967227190"));
    var results =jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this .description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];

    });
  }
  @override
  void initState () {
    super.initState();
    this.getweather();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height /3,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Currently in Lagos",
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 14.0,
                         fontWeight: FontWeight.w600,
                       ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u00b0" : "Loading",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                    padding:EdgeInsets.only(top: 10.0,),
                  child: Text(
                    currently != null ? currently.toString() : "Loading",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),

          ),
          Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                      title: Text("temperature"),
                      trailing: Text(temp != null ? temp.toString() + "\u00b0" : "Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.cloud),
                      title: Text("Weather"),
                      trailing: Text(description != null ? description.toString() : "Loading",),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.sun),
                      title: Text("Humidity"),
                      trailing: Text(humidity != null ? humidity.toString() : "Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.wind),
                      title: Text("Wind Speed"),
                      trailing: Text(windSpeed != null ? windSpeed.toString() : "Loading"),
                    )
                  ],
                ),

              )
          )
        ],
      ),
    );
  }
}

