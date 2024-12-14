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
  String? training_name;
  String? date;
  String? time;
  String? location;
  String? price;
  String? trainer_name;
  String? trainer_image;
  String? training_image;

  Training(
      {this.id,
      this.training_name,
      this.date,
      this.time,
      this.location,
      this.price,
      this.trainer_name,
      this.trainer_image,
      this.training_image});

  Training.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    training_name = json['training_name'];
    date = json['date'];
    time = json['time'];
    location = json['location'];
    price = json['price'];
    trainer_name = json['trainer_name'];
    trainer_image = json['trainer_image'];
    training_image = json['training_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['training_name'] = training_name;
    data['date'] = date;
    data['time'] = time;
    data['location'] = location;
    data['price'] = price;
    data['trainer_name'] = trainer_name;
    data['trainer_image'] = trainer_image;
    data['training_image'] = training_image;
    return data;
  }
}
