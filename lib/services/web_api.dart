import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;

import 'package:dio/dio.dart';
import 'package:web_scrapping/models/articles.dart';

final _dio = Dio();

List<Articles> _articles = [];
List<Articles> get articles => _articles;
// List<ClassSchedule> _schedules = [];
// List<ClassSchedule> get schedules => _schedules;

class WebApi {
  WebApi();

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

      final titles = html
          .querySelectorAll(
              "table.table.table-custom.table-primary.table-fixed.bordered-table.stacktable.large-only > tbody > tr > td")
          .map((e) => e.innerHtml)
          .toList();
      return titles;
    } on DioError catch (e) {
      debugPrint(e.message);
    }
  }
}
