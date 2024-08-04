import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../riverpod.dart';
import '../../../settings/inherited_theme_notifier.dart';
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

  final Map<String, TextEditingController> filterControllers = {
    'make': TextEditingController(),
    'model': TextEditingController(),
    'year': TextEditingController(),
    'fuel_type': TextEditingController(),
    'drive': TextEditingController(),
    'cylinders': TextEditingController(),
    'transmission': TextEditingController(),
    'min_city_mpg': TextEditingController(),
    'max_city_mpg': TextEditingController(),
    'min_hwy_mpg': TextEditingController(),
    'max_hwy_mpg': TextEditingController(),
    'min_comb_mpg': TextEditingController(),
    'max_comb_mpg': TextEditingController(),
  };

  final List<String> searchParameters = [
    'make',
    'model',
    'year',
    'fuel_type',
    'drive',
    'cylinders',
    'transmission',
    'min_city_mpg',
    'max_city_mpg',
    'min_hwy_mpg',
    'max_hwy_mpg',
    'min_comb_mpg',
    'max_comb_mpg',
  ];

  final List<int> limitOptions = [5, 10, 20, 50];

  final Map<String, List<String>> parameterOptions = {
    'fuel_type': ['gas', 'diesel', 'electricity'],
    'drive': ['fwd', 'rwd', 'awd', '4wd'],
    'cylinders': ['2', '3', '4', '5', '6', '8', '10', '12', '16'],
    'transmission': ['m', 'a'],
  };

  List<String> activeFilters = [];

  @override
  Widget build(BuildContext context) {
    final themeController = InheritedThemeNotifier.maybeOf(context);
    final mainVm = ref.watch(mainVM);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cars"),
        actions: [
          DropdownButton<ThemeMode>(
            value: themeController?.themeMode ?? ThemeMode.system,
            onChanged: (ThemeMode? newMode) {
              if (newMode != null) {
                setState(() {
                  themeController?.switchThemeMode(newMode);
                });
              }
            },
            items: ThemeMode.values.map((ThemeMode mode) {
              return DropdownMenuItem<ThemeMode>(
                value: mode,
                child: Text(mode.toString().split('.').last),
              );
            }).toList(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
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
                        ElevatedButton(
                          onPressed: () {
                            if (!activeFilters.contains(selectedParameter)) {
                              setState(() {
                                activeFilters.add(selectedParameter);
                              });
                            }
                          },
                          child: const Text("Add Filter"),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    Column(
                      children: [
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
                        ElevatedButton(
                          onPressed: () {
                            Map<String, String?> filters = {};
                            for (var key in activeFilters) {
                              filters[key] = filterControllers[key]!.text;
                            }
                            mainVm.searchCars(
                              limit: selectedLimit,
                              filters: filters,
                            );
                          },
                          child: const Text("Search"),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  children: activeFilters.map((parameter) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 150,
                            child: parameterOptions.containsKey(parameter)
                                ? DropdownButton<String>(
                                    value: filterControllers[parameter]!
                                            .text
                                            .isNotEmpty
                                        ? filterControllers[parameter]!.text
                                        : parameterOptions[parameter]!.first,
                                    items: parameterOptions[parameter]!
                                        .map((String option) {
                                      return DropdownMenuItem<String>(
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        filterControllers[parameter]!.text =
                                            newValue!;
                                      });
                                    },
                                  )
                                : TextField(
                                    controller: filterControllers[parameter],
                                    decoration: InputDecoration(
                                      labelText: parameter,
                                    ),
                                  ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove_circle),
                            onPressed: () {
                              setState(() {
                                activeFilters.remove(parameter);
                                filterControllers[parameter]!.clear();
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
