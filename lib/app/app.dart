import 'package:acumap/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:acumap/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:acumap/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:acumap/ui/views/home/home_view.dart';
import 'package:acumap/ui/views/gallery/gallery_view.dart';
import 'package:acumap/ui/views/map/map_view.dart';
import 'package:acumap/ui/views/search/search_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: GalleryView),
    MaterialRoute(page: MapView),
    MaterialRoute(page: SearchView),
// @stacked-route
  ],
  logger: StackedLogger(),
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
