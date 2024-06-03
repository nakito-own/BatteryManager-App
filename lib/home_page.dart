import 'package:flutter/material.dart';
import 'api_service.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController routesController = TextEditingController();
  TextEditingController distributionController = TextEditingController();
  String routesOutput = '';
  String distributionOutput = '';

  void sendData() async {
    try {
      final data = await ApiService.sendData(
        routesController.text,
        distributionController.text,
      );
      setState(() {
        routesOutput = data['routes_output'];
        distributionOutput = data['distribution_output'];
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    routesController.addListener(sendData);
    distributionController.addListener(sendData);
  }

  @override
  void dispose() {
    routesController.dispose();
    distributionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Routes and Distribution'),
      ),
      backgroundColor: Colors.lightBlue[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Routes Text:', style: TextStyle(fontSize: 16)),
              TextField(
                controller: routesController,
                maxLines: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text('Distribution Text:', style: TextStyle(fontSize: 16)),
              TextField(
                controller: distributionController,
                maxLines: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text('Routes Output:', style: TextStyle(fontSize: 16)),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Text(routesOutput),
              ),
              SizedBox(height: 20),
              Text('Distribution Output:', style: TextStyle(fontSize: 16)),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Text(distributionOutput),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
