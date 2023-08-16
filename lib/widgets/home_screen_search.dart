import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:maveshi/widgets/round_button.dart';

class HomeScreenSearchWidget extends StatefulWidget {
  final searchController = TextEditingController();

  HomeScreenSearchWidget({
    super.key,
    required TextEditingController searchController,
  });

  @override
  State<HomeScreenSearchWidget> createState() => _HomeScreenSearchWidgetState();
}

class _HomeScreenSearchWidgetState extends State<HomeScreenSearchWidget> {
  String? selectedAnimalType;
  String? selectedPriceRange;
  String? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Animal Type',
              border: OutlineInputBorder(),
            ),
            value: selectedAnimalType,
            items: const [
              DropdownMenuItem(
                value:
                    '', // Use an empty string as the value for the empty option
                child: Text('Select an animal type'),
              ),
              DropdownMenuItem(
                value: 'Cow',
                child: Text('Cow'),
              ),
              DropdownMenuItem(
                value: 'Buffalo',
                child: Text('Buffalo'),
              ),
              DropdownMenuItem(
                value: 'Sheep',
                child: Text('Sheep'),
              ),
              DropdownMenuItem(
                value: 'Goat',
                child: Text('Lamb'),
              ),
              DropdownMenuItem(
                value: 'Others',
                child: Text('Sheep'),
              ),
              // Rest of the DropdownMenuItems
            ],
            onChanged: (String? value) {
              setState(() {
                selectedAnimalType = value;
              });
            },
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Location',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                selectedLocation = value;
              });
            },
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Minimum Price',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedPriceRange = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Maximum Price',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedPriceRange = value;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          RoundButton(
            title: "search".tr,
            onPress: () {
              if (selectedAnimalType != null &&
                  selectedPriceRange != null &&
                  selectedLocation != null) {
                // Perform search based on selectedAnimalType and selectedPriceRange
              }
            },
          ),
        ],
      ),
    );
  }
}
