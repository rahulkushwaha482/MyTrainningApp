import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_trainning_aaps/provider/trainning_list_provider.dart';

class FilterContent extends StatelessWidget {
  Widget _buildLocationFilter(TrainingListProvider trainingProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: 'Search Location',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
          onChanged: (query) {
            trainingProvider.locationFilters =
                trainingProvider.locationFilters.map((key, value) {
              return MapEntry(
                  key, key.toLowerCase().contains(query.toLowerCase()));
            });
          },
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView(
            children: trainingProvider.locationFilters.keys.map((location) {
              return CheckboxListTile(
                title: Text(location),
                value: trainingProvider.locationFilters[location],
                onChanged: (value) {
                  trainingProvider.locationFilters[location] = value!;

                  final selectedLocations = trainingProvider
                      .locationFilters.entries
                      .where((entry) => entry.value)
                      .map((entry) => entry.key)
                      .toList();
                  print(selectedLocations);
                  print(value);
                  trainingProvider
                      .filterTrainingListByLocation(selectedLocations);
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildOtherContent(
      TrainingListProvider provider, int selectedTabIndex) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: selectedTabIndex == 2
                ? 'Search Training Name'
                : 'Search Trainer Name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: (query) {
            provider.updateSearchQuery(query); // Save query
          },
          // onChanged: (query) {
          //   provider.updateSearchQuery(query);
          //   if (selectedTabIndex == 2) {
          //     provider.filterUsingTrainingName(provider.searchQuery);
          //   } else if (selectedTabIndex == 3) {
          //     provider.filterUsingTrainerName(provider.searchQuery);
          //   } else {
          //     //provider.filterUsingTrainerName(provider.searchQuery);
          //   }
          // },
          onSubmitted: (query) {
            provider.updateSearchQuery(query);
            if (selectedTabIndex == 2) {
              provider.filterUsingTrainingName(provider.searchQuery);
            } else if (selectedTabIndex == 3) {
              provider.filterUsingTrainerName(provider.searchQuery);
            } else {
              //provider.filterUsingTrainerName(provider.searchQuery);
            }
            // FocusScope.of().unfocus(); // Dismiss the keyboard
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final trainingProvider = Provider.of<TrainingListProvider>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Sort and Filters',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'TimeNewRoman',
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            const Divider(height: 1.5),
            Expanded(
              child: Row(
                children: [
                  // Left Navigation Tabs
                  Container(
                    width: 130,
                    color: Colors.grey[200],
                    child: ListView(
                      children: [
                        TabItem(
                          title: 'Sort by',
                          isSelected: trainingProvider.selectedTabIndex == 0,
                          onTap: () {},
                        ),
                        TabItem(
                            title: 'Location',
                            isSelected: trainingProvider.selectedTabIndex == 1,
                            onTap: () {
                              trainingProvider.selectedTabIndex = 1;
                              trainingProvider.updateTabIndex(1);
                            }),
                        TabItem(
                            title: 'Training Name',
                            isSelected: trainingProvider.selectedTabIndex == 2,
                            onTap: () {
                              trainingProvider.selectedTabIndex = 2;
                              trainingProvider.updateTabIndex(2);
                            }),
                        TabItem(
                            title: 'Trainer',
                            isSelected: trainingProvider.selectedTabIndex == 3,
                            onTap: () {
                              trainingProvider.selectedTabIndex = 3;
                              trainingProvider.updateTabIndex(3);
                            }),
                      ],
                    ),
                  ),
                  // Right Content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: trainingProvider.selectedTabIndex == 1
                          ? _buildLocationFilter(trainingProvider)
                          : _buildOtherContent(trainingProvider,
                              trainingProvider.selectedTabIndex),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const TabItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        color: isSelected ? Colors.white : Colors.transparent,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.red : Colors.black54,
          ),
        ),
      ),
    );
  }
}
