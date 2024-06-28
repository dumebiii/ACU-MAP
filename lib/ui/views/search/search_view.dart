import 'package:acumap/ui/common/app_colors.dart';
import 'package:acumap/ui/common/ui_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:iconly/iconly.dart';

import 'search_viewmodel.dart';

class SearchView extends StackedView<SearchViewModel> {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SearchViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(
                top: 15.0, bottom: 3, left: 15, right: 15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 35,
                          color: kblue,
                        ),
                      ),
                      horizontalSpaceTiny,
                      Expanded(
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5.0,
                                blurRadius: 30.0,
                              ),
                            ],
                          ),
                          child: Row(
                            // crossAxisAlignment: ,
                            children: [
                              Image.asset('assets/images/log.png', height: 40),
                              horizontalSpaceSmall,
                              Expanded(
                                child: TextField(
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600,
                                    color: kblue,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: "Search location",
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  onChanged:
                                      // Handle search logic here
                                      (text) =>
                                          viewModel.onSearchTextChanged(text),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpaceMedium,
                  const Text(
                    'Suggested Locations',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      color: kblue,
                    ),
                  ),

                  // Container(
                  //   padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                  // ),

                  verticalSpaceSmall,
                  viewModel.isBusy
                      ? const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: kblue,
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                              itemCount: viewModel.resulttt!.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    viewModel.handleSearchResultTap(
                                        viewModel.resulttt![index].name!,
                                        viewModel.resulttt![index].geometry!
                                            .location!.lat!,
                                        viewModel.resulttt![index].geometry!
                                            .location!.lng!);
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: kblue,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0, right: 10),
                                              child: Text(
                                                viewModel.resulttt![index].name
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              )),
                                        ),
                                      ),
                                      verticalSpaceMedium
                                    ],
                                  ),
                                );
                              }))
                ])),
      ),
    );
  }

  @override
  SearchViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SearchViewModel();
}
