import 'package:acumap/app/app.locator.dart';
import 'package:acumap/app/app.router.dart';
import 'package:acumap/model/gallery.dart';
import 'package:acumap/model/gallerysub.dart';
import 'package:acumap/ui/views/gallery/sub_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class GalleryViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void navigateToSearchScreen() {
    _navigationService.navigateToSearchView();
  }

  void navigateToSubScreen(data, context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubView(
          data: data,
        ),
      ),
    );
  }

  final List<GallerySub> administrativebuildings = [
    GallerySub(
        name: 'Vice-Chancellor',
        image: 'assets/images/vc.jpeg',
        findme: "7.848748875016959, 3.9468986078007537"),
    GallerySub(
        name: 'Vice-Chancellor',
        image: 'assets/images/vc.jpeg',
        findme: "7.848748875016959, 3.9468986078007537")
  ];

  final List<GalleryMain> gallery = [
    GalleryMain(
      name: 'Administrative',
      subs: [
        GallerySub(
            name: 'Registrar\'s office',
            image: 'assets/images/admin/registrar3.png',
            findme: "7.848748875016959, 3.9468986078007537"),
        GallerySub(
            name: 'Crowther Hall',
            image: 'assets/images/admin/crowther.png',
            findme: "7.848748875016959, 3.9468986078007537"),
        GallerySub(
            name: 'ACU Bakery',
            image: 'assets/images/admin/bake.png',
            findme: "7.848748875016959, 3.9468986078007537"),
        GallerySub(
            name: 'ACU Laundry',
            image: 'assets/images/admin/laund.png',
            findme: "7.848748875016959, 3.9468986078007537")
      ],
    ),
    GalleryMain(
      name: 'Faculties',
      subs: [
        GallerySub(
            name: 'Natural Sciences',
            image: 'assets/images/fns.jpg',
            findme: "7.848748875016959, 3.9468986078007537"),
        GallerySub(
            name: 'Law',
            image: 'assets/images/law.jpg',
            findme: "7.847973659189036, 3.9503456746065178"),
        GallerySub(
            name: 'Engineering',
            image: 'assets/images/faculties/engi.png',
            findme: "7.847973659189036, 3.9503456746065178"),
        GallerySub(
            name: 'Engineering',
            image: 'assets/images/faculties/masscom.png',
            findme: "7.847973659189036, 3.9503456746065178")
      ],
    ),
    GalleryMain(
      name: 'Hostels',
      subs: [
        GallerySub(
            name: 'JAH Hostel',
            image: 'assets/images/jah.jpg',
            findme: "7.848748875016959, 3.9468986078007537"),
        GallerySub(
            name: 'Ibadan Hostel',
            image: 'assets/images/ibadan.jpg',
            findme: "7.84762475003959, 3.9463318549921875"),
        GallerySub(
            name: 'DLW Hostel',
            image: 'assets/images/hostel/dlw.png',
            findme: "7.84762475003959, 3.9463318549921875"),
        GallerySub(
            name: 'Goshen Inn',
            image: 'assets/images/hostel/goshen.png',
            findme: "7.84762475003959, 3.9463318549921875")
      ],
    ),
    GalleryMain(
      name: 'Utilities',
      subs: [
        GallerySub(
            name: 'Christoy',
            image: 'assets/images/utilities/chris.png',
            findme: "7.848748875016959, 3.9468986078007537"),
        GallerySub(
            name: 'Complex',
            image: 'assets/images/utilities/complex.png',
            findme: "7.84762475003959, 3.9463318549921875"),
        GallerySub(
            name: 'Mini Mart',
            image: 'assets/images/utilities/min.png',
            findme: "7.84762475003959, 3.9463318549921875")
      ],
    ),
  ];
  // final List<GallerySub> administrativebuildings = [
  //   const GallerySub(name: 'Vice-Chancellor', image: 'assets/images/vc.jpeg'),
  //   const GallerySub(name: 'Vice-Chancellor', image: 'assets/images/vc.jpeg'),
  // ];

  // final List<GalleryMain> gallery = [
  //   GalleryMain(name: 'Administrative building', subs: administrativebuildings)
  // ];
}
