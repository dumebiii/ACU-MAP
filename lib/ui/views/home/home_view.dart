import 'package:acumap/ui/common/app_colors.dart';
import 'package:acumap/ui/views/gallery/gallery_view.dart';
import 'package:acumap/ui/views/map/map_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:iconly/iconly.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    final glbKey = GlobalKey();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                color: Colors.transparent, spreadRadius: 0, blurRadius: 15),
          ],
        ),
        child: BottomNavigationBar(
          key: glbKey,
          type: BottomNavigationBarType.fixed,
          backgroundColor: kblue,
          currentIndex: viewModel.currentIndex,
          onTap: viewModel.setIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                IconlyBroken.home,
                color: kgold,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                IconlyBroken.image,
                color: kgold,
              ),
              label: 'Gallery',
            ),
          ],
        ),
      ),
      body: getViewForIndex(viewModel.currentIndex),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return const MapView();
      case 1:
        return const GalleryView();

      default:
        return const MapView();
    }
  }
}
