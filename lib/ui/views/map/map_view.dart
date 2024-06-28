import 'package:acumap/ui/common/app_colors.dart';
import 'package:acumap/ui/common/icontwotext.dart';
import 'package:acumap/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:iconly/iconly.dart';

import 'map_viewmodel.dart';

class MapView extends StackedView<MapViewModel> {
  const MapView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MapViewModel viewModel,
    Widget? child,
  ) {
    double width = MediaQuery.of(context).size.width;

    final LatLng southwest = LatLng(
        viewModel.schoolLocation.latitude - viewModel.offset,
        viewModel.schoolLocation.longitude - viewModel.offset);
    final LatLng northeast = LatLng(
        viewModel.schoolLocation.latitude + viewModel.offset,
        viewModel.schoolLocation.longitude + viewModel.offset);
    final LatLngBounds bounds =
        LatLngBounds(southwest: southwest, northeast: northeast);

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  color: kblue,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/images/log.png', height: 45),
                        // const Expanded(
                        //   child: Column(
                        //     mainAxisSize: MainAxisSize.min,
                        //     children: [
                        // Text(
                        //   'AJAYI CROWTHER UNIVERISTY',
                        //   softWrap: true,
                        //   style: TextStyle(
                        //     fontSize: 20,
                        //     fontFamily: "Poppins",
                        //     fontWeight: FontWeight.w600,
                        //     color: Colors.white,
                        //   ),
                        // ),
                        const Center(
                          child: Text(
                            'CAMPUS MAP',
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w900,
                              color: kgold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            viewModel.navigateToSearchScreen();
                          },
                          icon: const Icon(
                            IconlyBroken.search,
                            color: kgold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                // https://www.youtube.com/watch?v=M7cOmiSly3Q
                viewModel.currentposition == null
                    ? const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: kblue,
                          ),
                        ),
                      )
                    : Expanded(
                        child: Stack(
                          children: [
                            GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: viewModel.destinationName!.isEmpty
                                    ? viewModel.schoolLocation
                                    : viewModel.currentposition!,
                                zoom: 20.0,
                              ),
                              minMaxZoomPreference:
                                  const MinMaxZoomPreference(17, 18),
                              polylines: viewModel.polylines,
                              mapType: viewModel.ishybrid == false
                                  ? MapType.normal
                                  : MapType.hybrid,
                              mapToolbarEnabled: true,
                              zoomControlsEnabled: false,
                              circles: {
                                Circle(
                                  circleId: const CircleId("1"),
                                  center: viewModel.schoolLocation,
                                  radius: viewModel.raduis,
                                  strokeWidth: 1,
                                  fillColor: kblue.withOpacity(0.2),
                                ),
                              },
                              onCameraMove: (position) {
                                viewModel.checkMarkerPosition(position.target);
                              },
                              zoomGesturesEnabled: true,
                              buildingsEnabled: true,
                              cameraTargetBounds: CameraTargetBounds(bounds),
                              onTap: (argument) {
                                viewModel.lattlngg = argument;
                              },
                              markers: {
                                Marker(
                                    markerId: const MarkerId("start position"),
                                    icon: viewModel.startIcon,
                                    position: viewModel.currentposition!),
                                Marker(
                                    markerId:
                                        const MarkerId("destination position"),
                                    icon: viewModel.destinationIcon,
                                    position: viewModel.destination!),
                                Marker(
                                    markerId: const MarkerId("school position"),
                                    position: viewModel.schoolLocation),
                              },
                              onMapCreated: (GoogleMapController controller) {
                                viewModel.controller.complete(controller);

                                viewModel.setPolylines();
                              },
                            ),

                            // : Center(
                            //     child: CircularProgressIndicator(
                            //       color: kblue,
                            //     ),
                            //   ),

                            if (viewModel.isMarkerOutside)
                              AlertDialog(
                                backgroundColor: kblue,
                                title: Image.asset(
                                  "assets/images/log.png",
                                  height: 100,
                                  width: 100,
                                ),
                                actionsPadding: const EdgeInsets.only(
                                    top: 0, left: 20, right: 20),
                                actionsAlignment: MainAxisAlignment.center,
                                actions: <Widget>[
                                  Center(
                                    child: RichText(
                                      text: const TextSpan(
                                        text: 'You are outside',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                '\n Ajayi Crowther University',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w600,
                                              color: kgold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  verticalSpaceSmall,
                                  const Text(
                                    'kindly move back to highlighted area',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w300,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white,
                                    ),
                                  ),
                                  verticalSpaceMedium,
                                  Center(
                                    child: SizedBox(
                                      height: 40,
                                      width: 140,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'Back',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w600,
                                            color: kblue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  verticalSpaceMedium,
                                ],
                              ),
                            viewModel.destinationName!.isEmpty
                                ? Container()
                                : Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20, left: 20, bottom: 30),
                                          child: Material(
                                            elevation: 5,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            child: Container(
                                              height: 170,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  color: Colors.white),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: IconcolText(
                                                            font1: 16,
                                                            font2: 14,
                                                            icon: Container(
                                                                height: 40,
                                                                width: 40,
                                                                decoration: const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color:
                                                                        kblue),
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .access_time_rounded,
                                                                  size: 24,
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                            firsttext:
                                                                "${viewModel.calculateTravelTime().round().toString()} mins",
                                                            sectext: 'Duration',
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration:
                                                              const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: kblue),
                                                          child: IconButton(
                                                            icon: Icon(
                                                              viewModel.ishybrid ==
                                                                      false
                                                                  ? Icons.layers
                                                                  : Icons
                                                                      .layers_outlined,
                                                              size: 35,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            onPressed: () {
                                                              viewModel
                                                                  .toggleHybridView();
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    verticalSpaceMedium,
                                                    IconcolText(
                                                      font1: 15,
                                                      font2: 14,
                                                      icon: Container(
                                                          height: 40,
                                                          width: 40,
                                                          decoration:
                                                              const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: kblue),
                                                          child: const Icon(
                                                            Icons.location_pin,
                                                            size: 24,
                                                            color: Colors.white,
                                                          )),
                                                      firsttext: viewModel
                                                          .destinationName!,
                                                      sectext: 'Destination',
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
              ]),
        ));
  }

  @override
  MapViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MapViewModel();

  @override
  void onModelReady(MapViewModel viewModel) {
    viewModel.initialise();
    super.onViewModelReady(viewModel);
  }
}
