import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_trainning_aaps/model/trainning_model.dart';
import 'package:my_trainning_aaps/provider/trainning_list_provider.dart';
import 'package:provider/provider.dart';
import 'filter_content_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<TrainingListProvider>(context, listen: false)
        .getTrainingListItems();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trainings',
            style: TextStyle(
                fontFamily: 'TimeNewRoman',
                fontSize: 34,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                color: Colors.red,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 18.0, top: 20),
                child: Text(
                  'Highlights',
                  style: TextStyle(
                      fontFamily: 'TimeNewRoman',
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Consumer<TrainingListProvider>(
                  builder: (context, provider, child) {
                    final data = provider.crausalTrainingData;
                    return CarouselSlider.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) =>
                          buildHighlightCard(data[itemIndex]),
                      options: CarouselOptions(
                        height: 150.0,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        scrollDirection: Axis.horizontal,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(0.0)),
                    ),
                    builder: (context) => GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: FilterContent()),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                    border: Border.all(color: Colors.grey), // Border color
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.filter_list,
                        color: Colors.grey,
                        size: 18, // Icon size
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Filter",
                        style: TextStyle(
                          fontFamily: 'TimeNewRoman',
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<TrainingListProvider>(
              builder: (context, provider, child) {
                print('provider.trainingData.length');
                print(provider.trainingData.length);
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: provider.trainingData.length,
                  itemBuilder: (context, index) {
                    final data = provider.trainingData[index];
                    return trainingCardWidget(data);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHighlightCard(Training data) {
    return Card(
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  data.training_image.toString(),
                  fit: BoxFit.fill,
                )),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.training_name.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'TimeNewRoman',
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  data.date.toString(),
                  style: const TextStyle(
                      color: Colors.white70,
                      fontFamily: 'TimeNewRoman',
                      fontSize: 14),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\u{20B9}${data.price.toString()}',
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontFamily: 'TimeNewRoman',
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton.icon(
                      iconAlignment: IconAlignment.end,
                      onPressed: () {},
                      label: const Text('View Details',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'TimeNewRoman',
                          )),
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget trainingCardWidget(Training data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.date.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          data.time.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          data.location.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: DottedLine(
                      dashColor: Colors.grey,
                      direction: Axis.vertical,
                      alignment: WrapAlignment.center,
                      lineLength: 150,
                      lineThickness: 2.0,
                      dashLength: 8.0,
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Filling Fast!',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          data.training_name ?? 'Training Name',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'TimeNewRoman',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 16,
                              backgroundImage:
                                  AssetImage('assets/images/trainer_image.png'),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Keynote Speaker',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'TimeNewRoman',
                                  ),
                                ),
                                Text(
                                  data.trainer_name ?? 'Trainer Name',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'TimeNewRoman',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: const Text('Enroll Now'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
