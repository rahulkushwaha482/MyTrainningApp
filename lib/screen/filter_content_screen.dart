import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_trainning_aaps/provider/trainning_list_provider.dart';

class FilterContent extends StatefulWidget {
  const FilterContent({super.key});

  @override
  State<FilterContent> createState() => _FilterContentState();
}

class _FilterContentState extends State<FilterContent> {
  int selectedTabIndex = 1;
  Map<String, bool> locationFilters = {
    'Delhi': false,
    'Bangalore': false,
    'Pune': false,
    'Hyderabad': false,
    'Noida': false,
  };

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
            setState(() {
              locationFilters = locationFilters.map((key, value) {
                return MapEntry(
                    key, key.toLowerCase().contains(query.toLowerCase()));
              });
            });
          },
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView(
            children: locationFilters.keys.map((location) {
              return CheckboxListTile(
                title: Text(location),
                value: locationFilters[location],
                onChanged: (value) {
                  setState(() {
                    locationFilters[location] = value!;
                  });

                  // Notify the provider with the selected locations
                  final selectedLocations = locationFilters.entries
                      .where((entry) => entry.value)
                      .map((entry) => entry.key)
                      .toList();

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

  Widget _buildOtherContent() {
    return const Center(
      child: Text(
        'Content for this tab will appear here.',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final trainingProvider = Provider.of<TrainingListProvider>(context);

    return SizedBox(
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: 120,
                color: Colors.grey[200],
                child: ListView(
                  children: [
                    TabItem(
                      title: 'Sort by',
                      isSelected: selectedTabIndex == 0,
                      onTap: () => setState(() => selectedTabIndex = 0),
                    ),
                    TabItem(
                      title: 'Location',
                      isSelected: selectedTabIndex == 1,
                      onTap: () => setState(() => selectedTabIndex = 1),
                    ),
                    TabItem(
                      title: 'Training Name',
                      isSelected: selectedTabIndex == 2,
                      onTap: () => setState(() => selectedTabIndex = 2),
                    ),
                    TabItem(
                      title: 'Trainer',
                      isSelected: selectedTabIndex == 3,
                      onTap: () => setState(() => selectedTabIndex = 3),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: selectedTabIndex == 1
                      ? _buildLocationFilter(trainingProvider)
                      : _buildOtherContent(),
                ),
              ),
            ],
          ),
        ],
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
