import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../riverpod.dart';
import '../../view_model/data/repository/main_repo.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  final TextEditingController searchController = TextEditingController();
  String selectedParameter = 'make';
  int selectedLimit = 10;

  final List<String> searchParameters = [
    'make',
    'fuel_type',
    'drive',
    'cylinders',
    'transmission',
    'year',
    'min_city_mpg',
    'max_city_mpg'
  ];

  final List<int> limitOptions = [5, 10, 20, 50];

  @override
  Widget build(BuildContext context) {
    final mainVm = ref.watch(mainVM);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cars"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration:
                        const InputDecoration(labelText: 'Search Value'),
                  ),
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: selectedParameter,
                  items: searchParameters.map((String parameter) {
                    return DropdownMenuItem<String>(
                      value: parameter,
                      child: Text(parameter),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedParameter = newValue!;
                    });
                  },
                ),
                const SizedBox(width: 8),
                DropdownButton<int>(
                  value: selectedLimit,
                  items: limitOptions.map((int limit) {
                    return DropdownMenuItem<int>(
                      value: limit,
                      child: Text(limit.toString()),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedLimit = newValue!;
                    });
                  },
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    mainVm.searchCars(
                      searchParameter: selectedParameter,
                      searchValue: searchController.text,
                      limit: selectedLimit,
                    );
                  },
                  child: const Text("Search"),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Consumer(builder: (context, ref, _) {
                  final con = ref.watch(mainFetchData);
                  return con.when(
                    data: (data) => ListView.builder(
                      controller: ref.read(mainVM).scrollController,
                      itemCount: ref.read(mainVM).allCars.length,
                      itemBuilder: (_, index) {
                        final car = ref.read(mainVM).allCars[index];
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Make: ${car.make ?? 'Unknown'}"),
                                Text("Model: ${car.model ?? 'Unknown'}"),
                                Text("Year: ${car.year ?? 'Unknown'}"),
                                Text(
                                    "Fuel Type: ${car.fuelType?.toString() ?? 'Unknown'}"),
                                Text("Drive: ${car.drive ?? 'Unknown'}"),
                                Text(
                                    "Cylinders: ${car.cylinders ?? 'Unknown'}"),
                                Text(
                                    "Transmission: ${car.transmission?.toString() ?? 'Unknown'}"),
                                Text("City MPG: ${car.cityMpg ?? 'Unknown'}"),
                                Text(
                                    "Highway MPG: ${car.highwayMpg ?? 'Unknown'}"),
                                Text(
                                    "Combination MPG: ${car.combinationMpg ?? 'Unknown'}"),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    error: (error, stackTrace) => Text("Error: $error"),
                    loading: () => const CircularProgressIndicator(),
                  );
                }),
                // Visibility(
                //   visible: ref.watch(mainVM).isLoading,
                //   child: const CircularProgressIndicator(),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
