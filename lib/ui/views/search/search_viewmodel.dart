import 'package:acumap/app/app.locator.dart';
import 'package:acumap/model/api_response.dart';
import 'package:acumap/model/search.dart';
import 'package:acumap/ui/views/home/home_view.dart';
import 'package:acumap/utilities/api_handle/map_api.dart';
import 'package:acumap/utilities/api_handle/shared.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.router.dart';

class SearchViewModel extends FutureViewModel {
  final navigationService = locator<NavigationService>();
  final shareddata = locator<SharedDataService>();

  LatLng schoolLocation = const LatLng(7.849858790844228, 3.9479412490584567);

  Debouncer debouncer = Debouncer();

  String searchText = "";

  int raduis = 390;

  bool startedtyping = false;

  final map = MappingService();

  List<Results>? resulttt = [];

  void onSearchTextChanged(String text) {
    searchText = text;
    notifyListeners();

    print(searchText);
    debouncer.debounce(
      onDebounce: () => search(), // Call your search function
      duration: const Duration(milliseconds: 300), // Adjust delay as needed
    );
  }

  void handleSearchResultTap(String placeName, double lat, double lng) {
    shareddata.updateSelectedPlace(placeName, lat, lng);

    navigateToHomeScreen();

    // selectedPlaceName = placeName;
    // selectedPlaceLat = lat;
    // selectedPlaceLng = lng;
    // notifyListeners(); // Notify listeners of state change
    // print(selectedPlaceName);
    // navigateToHomeView(placeName, lat, lng);
  }

  void navigateToHomeScreen() {
    navigationService.clearStackAndShowView(const HomeView());
  }

  void navigateToHomeView(String selectedPlaceName, double selectedPlaceLat,
      double selectedPlaceLng) {
    navigationService.navigateTo(Routes.homeView, arguments: {
      'selectedPlaceName': selectedPlaceName,
      'selectedPlaceLat': selectedPlaceLat,
      'selectedPlaceLng': selectedPlaceLng,
    });
  }

  Future<List<Results?>> search() async {
    print(searchText);
    ApiResponse<List<Results>>? result =
        await map.search(schoolLocation, searchText, raduis);

    resulttt = result!.data!;

    print(resulttt);

    return Future.value(resulttt);
  }

  @override
  Future futureToRun() => search();
}
