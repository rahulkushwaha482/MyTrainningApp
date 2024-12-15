class TrainingModel {
  List<Training>? trainings;

  TrainingModel({this.trainings});

  TrainingModel.fromJson(Map<String, dynamic> json) {
    if (json['trainings'] != null) {
      trainings = <Training>[];
      json['trainings'].forEach((v) {
        trainings!.add(Training.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (trainings != null) {
      data['trainings'] = trainings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Training {
  int? id;
  String? trainingName;
  String? date;
  String? time;
  String? location;
  String? price;
  String? trainerName;
  String? trainerImage;
  String? trainingImage;

  Training(
      {this.id,
      this.trainingName,
      this.date,
      this.time,
      this.location,
      this.price,
      this.trainerName,
      this.trainerImage,
      this.trainingImage});

  Training.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trainingName = json['training_name'];
    date = json['date'];
    time = json['time'];
    location = json['location'];
    price = json['price'];
    trainerName = json['trainer_name'];
    trainerImage = json['trainer_image'];
    trainingImage = json['training_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['training_name'] = trainingName;
    data['date'] = date;
    data['time'] = time;
    data['location'] = location;
    data['price'] = price;
    data['trainer_name'] = trainerName;
    data['trainer_image'] = trainerImage;
    data['training_image'] = trainingImage;
    return data;
  }
}
