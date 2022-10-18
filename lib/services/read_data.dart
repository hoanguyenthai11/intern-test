import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/shoes.dart';

class Services {
  static Future<List<Shoes>> readJsonData() async {
    final jsondata = await rootBundle.loadString('data/shoes.json');

    final list = json.decode(jsondata)['shoes'] as List;

    return list.map((e) => Shoes.fromJson(e)).toList();
  }
}
