import 'package:flutter/material.dart';
import 'package:web_scrapping/models/baak.dart';
import 'package:web_scrapping/services/web_api.dart';
import 'package:web_scrapping/utils/finite_state.dart';

class HomeViewModel extends ChangeNotifier with FiniteState {
  final _dio = WebApi();
  List<ClassSchedule> _schedules = [];
  List<ClassSchedule> get schedules => _schedules;
  List<String> classSchedule = [];
  List<String> dayClass = [];
  List<String> course = [];
  List<String> timeClass = [];
  List<String> roomClass = [];
  List<String> lecturer = [];

  Future<void> getScheduleBAAK(String studentClass) async {
    setStateAction(StateAction.loading);

    try {
      _schedules.clear();
      classSchedule.clear();
      dayClass.clear();
      course.clear();
      timeClass.clear();
      roomClass.clear();
      lecturer.clear();
      print("data schedules : $_schedules");
      final response = await _dio.getScheduleBaak(studentClass);
      // print("data response: $response");
      int nomor = 1;
      for (final title in response) {
        // debugPrint(title);
        switch (nomor) {
          case 1:
            classSchedule.add(title);
            break;
          case 2:
            dayClass.add(title);
            break;
          case 3:
            course.add(title);
            break;
          case 4:
            timeClass.add(title);
            break;
          case 5:
            roomClass.add(title);
            break;
          case 6:
            lecturer.add(title);
            break;
        }

        nomor += 1;
        if (nomor > 6) {
          nomor = 1;
          continue;
        }
      }
      _schedules = List.generate(
        response.length ~/ 6,
        (index) => ClassSchedule(
          classSchedule: classSchedule[index],
          daySchedule: dayClass[index],
          courseSchedule: course[index],
          timeSchedule: timeClass[index],
          roomSchedule: roomClass[index],
          lecturerSchedule: lecturer[index],
        ),
      );
      setStateAction(StateAction.none);
    } catch (e) {
      setStateAction(StateAction.error);
    }
    notifyListeners();
  }
}
