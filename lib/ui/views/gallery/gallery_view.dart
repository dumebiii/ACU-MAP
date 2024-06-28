import 'package:acumap/ui/common/app_colors.dart';
import 'package:acumap/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:iconly/iconly.dart';

import 'gallery_viewmodel.dart';

class GalleryView extends StackedView<GalleryViewModel> {
  const GalleryView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    GalleryViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                            'CAMPUS GALLERY',
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 3, left: 15, right: 15),
                    child: ListView.builder(
                        itemCount: viewModel.gallery.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return GestureDetector(
                            onTap: () {
                              viewModel.navigateToSubScreen(
                                  viewModel.gallery[index], context);
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: kblue,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(
                                    child: Text(
                                      viewModel.gallery[index].name!
                                          .toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 25,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w900,
                                        color: kgold,
                                      ),
                                    ),
                                  ),
                                ),
                                verticalSpaceSmall
                              ],
                            ),
                          );
                        }),
                  ),
                )
              ]),
        ));
  }

  @override
  GalleryViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      GalleryViewModel();
}
