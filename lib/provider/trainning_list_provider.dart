import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:my_trainning_aaps/model/trainning_model.dart';

class TrainingListProvider with ChangeNotifier {
  List<Training> _allTrainingData = [];
  List<Training> _filteredTrainingData = [];

  List<Training> get trainingData => _filteredTrainingData;
  List<Training> get crausalTrainingData => _allTrainingData;

  Future<void> getTrainingListItems() async {
    try {
      String rootData =
          await rootBundle.loadString('assets/training_list.json');
      Map<String, dynamic> data = json.decode(rootData);
      var listData = TrainingModel.fromJson(data);
      _allTrainingData = listData.trainings ?? [];
      _filteredTrainingData = List.from(_allTrainingData); // Initially show all
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading training data: $e');
    }
  }

  void filterUsingTrainerName(String query) {
    if (query.isEmpty) {
      _resetFilteredList();
    } else {
      _filteredTrainingData = _allTrainingData.where((training) {
        return training.trainer_name
                ?.toLowerCase()
                .contains(query.toLowerCase()) ??
            false;
      }).toList();
    }
    notifyListeners();
  }

  void filterUsingTrainingName(String query) {
    if (query.isEmpty) {
      _resetFilteredList();
    } else {
      _filteredTrainingData = _allTrainingData.where((training) {
        return training.training_name
                ?.toLowerCase()
                .contains(query.toLowerCase()) ??
            false;
      }).toList();
    }
    notifyListeners();
  }

  void filterTrainingListByLocation(List<String> selectedLocations) {
    if (selectedLocations.isEmpty) {
      _resetFilteredList();
    } else {
      _filteredTrainingData = _allTrainingData.where((training) {
        return selectedLocations.contains(training.location);
      }).toList();
    }
    notifyListeners();
  }

  void _resetFilteredList() {
    _filteredTrainingData = List.from(_allTrainingData);
  }
}
