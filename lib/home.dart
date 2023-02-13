import 'package:flutter/material.dart';
import 'package:web_scrapping/services/web_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _webService = WebApi();
  // List<Articles> articles = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _webService.getWebsiteData();
    _webService.getScheduleBaak("2IA01");
  }

  @override
  Widget build(BuildContext context) {
    print("data");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Web Scrapping"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: schedules.length,
          itemBuilder: (context, index) {
            // final article = articles[index];
            final schedule = schedules[index];
            // print(schedule);
            // return ListTile(
            //   title: Text(schedule.daySchedule),
            //   leading: Text(schedule.courseSchedule),
            // );

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(schedule.classSchedule),
                    Text(schedule.daySchedule),
                    Text(schedule.courseSchedule),
                    Text(schedule.timeSchedule),
                    Text(schedule.roomSchedule),
                    Text(schedule.lecturerSchedule),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
