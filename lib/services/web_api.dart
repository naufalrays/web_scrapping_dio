import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;

import 'package:dio/dio.dart';
import 'package:web_scrapping/models/articles.dart';
import 'package:web_scrapping/models/baak.dart';

final _dio = Dio(
    // BaseOptions(
    //   baseUrl: "https://www.amazon.com/s?k=iphone",
    // ),
    );

List<Articles> _articles = [];
List<Articles> get articles => _articles;
List<ClassSchedule> _schedules = [];
List<ClassSchedule> get schedules => _schedules;
List<String> kelas = [];
List<String> hari = [];
List<String> matkul = [];
List<String> waktu = [];
List<String> ruang = [];
List<String> dosen = [];

class WebApi {
  WebApi() {
    // _dio.interceptors.add(
    //   LogInterceptor(
    //     responseBody: true,
    //     requestBody: true,
    //   ),
    // );
  }

  Future getWebsiteData() async {
    try {
      final response = await _dio.get(
          "https://www.tokopedia.com/search?st=product&q=iphone&srp_component_id=02.01.00.00&srp_page_id=&srp_page_title=&navsource=");
      dom.Document html = dom.Document.html(response.data);
      final titles = html
          .querySelectorAll(
              "div.css-974ipl > a > div.prd_link-product-name.css-3um8ox")
          .map((e) => e.innerHtml.trim())
          .toList();
      // print(titles);
      // for (final title in titles) {
      //   debugPrint(title);
      // }
      _articles = List.generate(
        titles.length,
        (index) => Articles(
          url: "",
          title: titles[index],
          urlImage: "",
        ),
      );
      debugPrint("count : ${titles.length}");
      // print(titles.toList());
      // print(titles[0]);
      // print(_articles[0].title);
    } catch (e) {
      // print(e);
    }
  }

  Future getScheduleBaak(String studentClass) async {
    try {
      final response = await _dio.get(
          "https://baak.gunadarma.ac.id/jadwal/cariJadKul?_token=n2p1eWcg5D6IlRTxStkqsSJKEOJ6j6m6GQHoeTFh&teks=$studentClass");
      dom.Document html = dom.Document.html(response.data);
      // final titles =
      //     html.querySelectorAll("td").map((e) => e.innerHtml.trim()).toList();
      // print(titles);
      final titles = html
          .querySelectorAll(
              "table.table.table-custom.table-primary.table-fixed.bordered-table.stacktable.large-only > tbody > tr > td")
          .map((e) => e.innerHtml)
          .toList();
      // final data = titles.take(4);
      int nomor = 1;
      for (final title in titles) {
        // debugPrint(title);
        switch (nomor) {
          case 1:
            // kelas = title;
            // ClassSchedule(
            //   classSchedule: title,
            //   courseSchedule: "",
            //   daySchedule: "",
            //   lecturerSchedule: "",
            //   roomSchedule: "",
            //   timeSchedule: "",
            // );
            kelas.add(title);
            // print("kelas $title");
            break;
          case 2:
            hari.add(title);
            // hari = title;
            // print("hari $title");

            break;
          case 3:
            matkul.add(title);
            // print("matkul $title");

            break;
          case 4:
            waktu.add(title);
            // print("waktu $title");
            break;
          case 5:
            ruang.add(title);
            // print("ruang $title");
            break;
          case 6:
            dosen.add(title);
            // print("dosen $title");
            break;
        }

        nomor += 1;
        if (nomor > 6) {
          nomor = 1;
          continue;
        }
        // print("kelas: $kelas");
        // print("hari : $hari");
        // print("hari : $matkul");
        // print("hari : $waktu");
        // print("hari : $ruang");
        // print("hari : $dosen");
      }

      // for (var i = 0; i < 5; i++) {
      //   print(titles);
      // }
      // debugPrint("banyak data: ${titles.length}");
      _schedules = List.generate(
        titles.length ~/ 6,
        (index) => ClassSchedule(
          classSchedule: kelas[index],
          daySchedule: hari[index],
          courseSchedule: matkul[index],
          timeSchedule: waktu[index],
          roomSchedule: ruang[index],
          lecturerSchedule: dosen[index],
        ),
      );

      // print('length ${titles.length}');
      // debugPrint("count : ${titles.length}");

      // print(titles.toList());
      // print(titles[0]);
      // print(_articles[0].title);
    } catch (e) {
      print(e);
    }
  }
}
