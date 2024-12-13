import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:my_trainning_aaps/model/trainning_model.dart';

class TrainingListProvider with ChangeNotifier {
  List<Training> trainingData = [];

  Future<void> getTrainingListItems() async {
    String rootData = await rootBundle.loadString('assets/training_list.json');
    Map<String, dynamic> data = json.decode(rootData);
    var listData = TrainingModel.fromJson(data);
    trainingData = listData.trainings!;
    notifyListeners();
  }
}
