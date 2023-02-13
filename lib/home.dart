import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_scrapping/utils/finite_state.dart';
import 'package:web_scrapping/view_models.dart/home_view_model.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // final _webService = WebApi();
  TextEditingController studentClassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // print("data");
    final dataProf = Provider.of<HomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Web Scrapping"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    width: 200,
                    child: TextFormField(
                      controller: studentClassController,
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: "4IA01",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 100,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Provider.of<HomeViewModel>(context, listen: false)
                          .getScheduleBAAK(studentClassController.text);
                    },
                    child: const Text("Submit"),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Consumer<HomeViewModel>(
                  builder: (context, value, child) {
                    print(value.actionState);
                    if (value.actionState == StateAction.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (value.actionState == StateAction.none) {
                      return value.schedules.isEmpty
                          ? const Text("Tidak ada datanya")
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(dataProf.schedules.length,
                                  (index) {
                                final schedule = value.schedules[index];
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(schedule.classSchedule),
                                        Text(schedule.daySchedule),
                                        Text(schedule.courseSchedule),
                                        Text(schedule.timeSchedule),
                                        Text(schedule.roomSchedule),
                                        Text(schedule.lecturerSchedule),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            );
                    } else {
                      return const Text("Error");
                    }
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
