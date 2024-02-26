import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_samarth/export.dart';

class WeatherWidget extends StatelessWidget {
  final String cityName;
  final String mainCondition;
  final double temperature;

  WeatherWidget({
    required this.cityName,
    required this.mainCondition,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Text(
            cityName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            getWeatherEmoji(mainCondition),
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${temperature.round()}℃',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            mainCondition,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String getWeatherEmoji(String mainCondition) {
    if (mainCondition == null) return '☀';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return '☁';
      case 'mist':
      case 'smoke':
      case 'dust':
      case 'haze':
      case 'fog':
        return '🌫';
      case 'rain':
        return '🌧';
      case 'drizzle':
      case 'shower rain':
        return '🌧';
      case 'thunderstorm':
        return '⛈';
      case 'clear':
        return '☀';
      default:
        return '☀';
    }
  }
}

class HomePage extends StatefulWidget {
  final String userEmail;

  HomePage({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _weatherService = WeatherService('bcf5171327ac7530193af60b33ae0368');
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: 
            Text(
              'नमस्ते! ${widget.userEmail}',
              style: TextStyle(fontSize: 20),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _weather != null
              ? Center(
                  child: WeatherWidget(
                    cityName: _weather!.cityName,
                    mainCondition: _weather!.mainCondition,
                    temperature: _weather!.temperature,
                  ),
                )
              : Container(),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'थोक विक्रेता से जुड़ें',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                _buildPersonItem('सूरज सिंह', '87953XXXXX', Icons.person, 'assets/p1.png'),
                _buildPersonItem('मोहन राजपूत', '98677XXXXX', Icons.person, 'assets/p2.png'),
                _buildPersonItem('श्याम प्रसाद', '89988XXXXX', Icons.person, 'assets/p3.png'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Logbook',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.new_releases),
            label: 'News',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CropListPage(),
              ),
            );
          }
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LogbookPage(userEmail: widget.userEmail),
              ),
            );
          }
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => News(),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(userEmail: widget.userEmail),
            ),
          );
        },
        child: Icon(Icons.person),
      ),
    );
  }

  Widget _buildPersonItem(String name, String phoneNumber, IconData iconData, String loc) {
    return ListTile(
      leading: CircleAvatar(
        child: Image.asset(loc),
      ),
      title: Text(name),
      subtitle: Text('$phoneNumber'),
    );
  }
}

class UserData {
  final String name;
  final String number;

  UserData({required this.name, required this.number});
}


// Expanded(
          //   child: FutureBuilder(
          //     future: fetchUserData(widget.userEmail),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return Center(child: CircularProgressIndicator());
          //       } else if (snapshot.hasError) {
          //         return Center(child: Text('Error fetching data'));
          //       } else {
          //         List<UserData> userDataList = snapshot.data as List<UserData>;
          //         return ListView.builder(
          //           itemCount: userDataList.length,
          //           itemBuilder: (context, index) {
          //             return ListTile(
          //               title: Text(userDataList[index].name),
          //               subtitle: Text('Number: ${userDataList[index].number}'),
          //             );
          //           },
          //         );
          //       }
          //     },
          //   ),
          // ),